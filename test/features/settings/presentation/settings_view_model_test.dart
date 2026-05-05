import 'package:flutter_learning_sample/features/settings/data/settings_repository.dart';
import 'package:flutter_learning_sample/features/settings/domain/user_preferences.dart';
import 'package:flutter_learning_sample/features/settings/presentation/settings_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// ViewModel 測試用的假 Repository。
///
/// 它把偏好存在記憶體，讓測試可以專注在 UI state 是否正確變化。
class FakeSettingsRepository implements SettingsRepository {
  FakeSettingsRepository(this.preferences);

  UserPreferences preferences;
  AppThemeMode? savedThemeMode;

  @override
  Future<UserPreferences> loadPreferences() async {
    return preferences;
  }

  @override
  Future<void> saveThemeMode(AppThemeMode themeMode) async {
    savedThemeMode = themeMode;
    preferences = preferences.copyWith(themeMode: themeMode);
  }
}

void main() {
  group('SettingsViewModel', () {
    test('loads preferences from repository', () async {
      final repository = FakeSettingsRepository(
        const UserPreferences(themeMode: AppThemeMode.light),
      );
      final container = ProviderContainer(
        overrides: [
          settingsRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);

      final preferences = await container.read(settingsViewModelProvider.future);

      expect(preferences.themeMode, AppThemeMode.light);
    });

    test('updates theme mode and persists the preference', () async {
      final repository = FakeSettingsRepository(
        const UserPreferences(themeMode: AppThemeMode.system),
      );
      final container = ProviderContainer(
        overrides: [
          settingsRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);

      await container.read(settingsViewModelProvider.future);
      await container
          .read(settingsViewModelProvider.notifier)
          .setThemeMode(AppThemeMode.dark);

      final state = container.read(settingsViewModelProvider).value;
      expect(repository.savedThemeMode, AppThemeMode.dark);
      expect(state?.themeMode, AppThemeMode.dark);
    });
  });
}
