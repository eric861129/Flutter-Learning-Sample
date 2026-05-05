import 'package:flutter_learning_sample/features/settings/data/settings_repository.dart';
import 'package:flutter_learning_sample/features/settings/domain/user_preferences.dart';
import 'package:flutter_learning_sample/services/storage_service.dart';
import 'package:flutter_test/flutter_test.dart';

/// 測試用的記憶體版 StorageService。
///
/// Repository test 不需要真的寫入裝置儲存空間，
/// 用 Map 模擬 key-value 儲存即可驗證轉換邏輯。
class FakeStorageService implements StorageService {
  final Map<String, String> _values = {};

  @override
  Future<String?> getString(String key) async {
    return _values[key];
  }

  @override
  Future<void> remove(String key) async {
    _values.remove(key);
  }

  @override
  Future<void> saveString(String key, String value) async {
    _values[key] = value;
  }
}

void main() {
  group('LocalSettingsRepository', () {
    test('returns system theme mode when no preference is saved', () async {
      final repository = LocalSettingsRepository(
        storageService: FakeStorageService(),
      );

      final preferences = await repository.loadPreferences();

      expect(preferences.themeMode, AppThemeMode.system);
    });

    test('saves and loads selected theme mode', () async {
      final storageService = FakeStorageService();
      final repository = LocalSettingsRepository(
        storageService: storageService,
      );

      await repository.saveThemeMode(AppThemeMode.dark);
      final preferences = await repository.loadPreferences();

      expect(preferences.themeMode, AppThemeMode.dark);
    });
  });
}
