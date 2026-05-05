import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router.dart';
import 'core/theme.dart';
import 'features/settings/domain/user_preferences.dart';
import 'features/settings/presentation/settings_view_model.dart';

/// App 的啟動入口。
///
/// 這裡只做一件事：把整個 Flutter app 放進 Riverpod 的 [ProviderScope]。
/// ProviderScope 是 Riverpod 的根容器，後續所有 Provider、Repository、
/// ViewModel 都會從這裡取得依賴。
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

/// App shell。
///
/// 教學重點：
/// - `main.dart` 不放頁面細節，避免入口檔越長越難讀。
/// - `MaterialApp.router` 負責接上宣告式路由。
/// - Theme 與 Router 都從 `core/` 匯入，形成清楚的 app-level 設定層。
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // MyApp 監聽 SettingsViewModel，讓使用者在設定頁切換主題時，
    // MaterialApp 可以立即套用新的 ThemeMode。
    final preferences = ref.watch(settingsViewModelProvider).valueOrNull ??
        const UserPreferences();

    return MaterialApp.router(
      title: 'Flutter Learning',
      // 全域亮色主題。實際定義放在 `lib/core/theme.dart`。
      theme: AppTheme.lightTheme,
      // 全域深色主題。系統切換深色模式時會自動套用。
      darkTheme: AppTheme.darkTheme,
      themeMode: preferences.themeMode.toThemeMode(),
      // App 的所有頁面路由集中在 `lib/core/router.dart`。
      routerConfig: appRouter,
    );
  }
}
