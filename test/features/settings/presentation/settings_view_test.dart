import 'package:flutter/material.dart';
import 'package:flutter_learning_sample/features/settings/data/settings_repository.dart';
import 'package:flutter_learning_sample/features/settings/domain/user_preferences.dart';
import 'package:flutter_learning_sample/features/settings/presentation/settings_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// SettingsView widget test 使用的假 Repository。
///
/// Widget test 只驗證畫面與互動，不依賴 SharedPreferences。
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
  group('SettingsView', () {
    testWidgets('renders current theme preference', (tester) async {
      final repository = FakeSettingsRepository(
        const UserPreferences(themeMode: AppThemeMode.dark),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            settingsRepositoryProvider.overrideWithValue(repository),
          ],
          child: const MaterialApp(home: SettingsView()),
        ),
      );

      await tester.pump();
      await tester.pump();

      expect(find.text('偏好設定'), findsOneWidget);
      expect(find.text('跟隨系統'), findsOneWidget);
      expect(find.text('亮色模式'), findsOneWidget);
      expect(find.text('深色模式'), findsOneWidget);
      expect(find.byType(RadioListTile<AppThemeMode>), findsNWidgets(3));
    });

    testWidgets('keeps the settings screen structure stable', (tester) async {
      final repository = FakeSettingsRepository(
        const UserPreferences(themeMode: AppThemeMode.system),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            settingsRepositoryProvider.overrideWithValue(repository),
          ],
          child: const MaterialApp(home: SettingsView()),
        ),
      );

      await tester.pump();
      await tester.pump();

      // Snapshot-style：固定設定頁的主要標題、區塊與選項數量。
      // 若未來 UI 結構被改壞，這個測試會比單純文字測試更早提醒。
      expect(find.text('偏好設定'), findsOneWidget);
      expect(find.text('主題模式'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(RadioListTile<AppThemeMode>), findsNWidgets(3));
      expect(find.text('跟隨系統'), findsOneWidget);
      expect(find.text('亮色模式'), findsOneWidget);
      expect(find.text('深色模式'), findsOneWidget);
    });

    testWidgets('saves selected theme mode when an option is tapped',
        (tester) async {
      final repository = FakeSettingsRepository(
        const UserPreferences(themeMode: AppThemeMode.system),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            settingsRepositoryProvider.overrideWithValue(repository),
          ],
          child: const MaterialApp(home: SettingsView()),
        ),
      );

      await tester.pump();
      await tester.pump();

      await tester.tap(find.text('深色模式'));
      await tester.pump();

      expect(repository.savedThemeMode, AppThemeMode.dark);
    });
  });
}
