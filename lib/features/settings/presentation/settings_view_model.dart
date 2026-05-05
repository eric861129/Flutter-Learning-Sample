import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/settings_repository.dart';
import '../domain/user_preferences.dart';

/// SettingsViewModel 的 provider。
///
/// AsyncNotifier 讓設定頁可以自然處理初始讀取中的 loading 狀態。
final settingsViewModelProvider =
    AsyncNotifierProvider<SettingsViewModel, UserPreferences>(
  SettingsViewModel.new,
);

/// 偏好設定畫面的 ViewModel。
///
/// ViewModel 管理 UI state 與使用者事件，並把保存細節交給 repository。
class SettingsViewModel extends AsyncNotifier<UserPreferences> {
  @override
  Future<UserPreferences> build() {
    return ref.read(settingsRepositoryProvider).loadPreferences();
  }

  /// 切換主題模式。
  ///
  /// 先保存到 repository，再更新記憶體中的 UI state。
  /// 這樣 app 重啟後仍能讀回使用者選擇。
  Future<void> setThemeMode(AppThemeMode themeMode) async {
    final currentPreferences = state.valueOrNull ?? const UserPreferences();

    await ref.read(settingsRepositoryProvider).saveThemeMode(themeMode);

    state = AsyncData(
      currentPreferences.copyWith(themeMode: themeMode),
    );
  }
}
