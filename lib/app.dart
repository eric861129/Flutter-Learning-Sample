import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router.dart';
import 'core/theme.dart';
import 'features/settings/domain/user_preferences.dart';
import 'features/settings/presentation/settings_view_model.dart';

/// App shell，也就是整個 Flutter app 的外殼。
///
/// 小白級理解：
/// - `main.dart` 像是「按下開機鍵」，只負責把 app 啟動。
/// - `app.dart` 像是「app 的總開關面板」，負責接上路由、主題和全域狀態。
/// - 這樣拆開後，初學者可以先讀 `main.dart`，再讀這個檔案，
///   不會一開始就被首頁、路由、主題混在一起嚇到。
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
