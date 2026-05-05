import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/storage_service.dart';
import '../domain/user_preferences.dart';

const _themeModeKey = 'settings.theme_mode';

/// SettingsRepository 的 provider。
///
/// Presentation layer 只依賴 SettingsRepository 抽象，
/// 不需要知道偏好設定實際存在 SharedPreferences。
final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => LocalSettingsRepository(
    storageService: ref.watch(storageServiceProvider),
  ),
);

/// Settings feature 的資料入口抽象。
///
/// 使用抽象介面可以讓 ViewModel 測試注入 fake repository，
/// 也讓未來改成本地資料庫或雲端同步時不影響 UI。
abstract class SettingsRepository {
  /// 載入使用者偏好設定。
  Future<UserPreferences> loadPreferences();

  /// 保存使用者選擇的主題模式。
  Future<void> saveThemeMode(AppThemeMode themeMode);
}

/// 使用 StorageService 保存偏好設定的 repository 實作。
///
/// Repository 負責把「有型別的 domain model」和「本地儲存字串」互相轉換。
class LocalSettingsRepository implements SettingsRepository {
  const LocalSettingsRepository({required StorageService storageService})
      : _storageService = storageService;

  final StorageService _storageService;

  @override
  Future<UserPreferences> loadPreferences() async {
    final storedThemeMode = await _storageService.getString(_themeModeKey);

    return UserPreferences(
      themeMode: AppThemeMode.fromStorageValue(storedThemeMode),
    );
  }

  @override
  Future<void> saveThemeMode(AppThemeMode themeMode) {
    return _storageService.saveString(_themeModeKey, themeMode.storageValue);
  }
}
