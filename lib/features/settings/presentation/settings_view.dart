import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/user_preferences.dart';
import 'settings_view_model.dart';

/// 使用者偏好設定頁。
///
/// 這個頁面示範 SharedPreferences + ThemeMode 的完整資料流：
/// UI 選擇主題模式，ViewModel 保存偏好，MyApp 讀取同一份 state 套用主題。
class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferencesAsync = ref.watch(settingsViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('偏好設定')),
      body: preferencesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => _SettingsErrorView(error: error),
        data: (preferences) => ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Text(
                '主題模式',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            for (final mode in AppThemeMode.values)
              RadioListTile<AppThemeMode>(
                title: Text(mode.label),
                value: mode,
                groupValue: preferences.themeMode,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }

                  ref
                      .read(settingsViewModelProvider.notifier)
                      .setThemeMode(value);
                },
              ),
          ],
        ),
      ),
    );
  }
}

/// 設定讀取失敗時的錯誤畫面。
///
/// 本地儲存通常很穩定，但教學範例仍示範 error state，
/// 讓初學者知道 AsyncValue 的三種狀態都應該被處理。
class _SettingsErrorView extends StatelessWidget {
  const _SettingsErrorView({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text('讀取設定失敗：$error'),
      ),
    );
  }
}
