import 'package:flutter/material.dart';

/// App 支援的主題模式選項。
///
/// 這個 enum 是教學用的 domain model：UI 不直接保存字串，
/// 而是用有型別的 AppThemeMode 表達使用者偏好。
enum AppThemeMode {
  /// 跟隨系統亮色/深色設定。
  system,

  /// 固定使用亮色主題。
  light,

  /// 固定使用深色主題。
  dark;

  /// 從 SharedPreferences 字串還原成 AppThemeMode。
  ///
  /// 若資料不存在或內容不是目前支援的值，就回到 system，
  /// 避免本地資料異常造成設定頁無法載入。
  static AppThemeMode fromStorageValue(String? value) {
    return AppThemeMode.values.firstWhere(
      (mode) => mode.storageValue == value,
      orElse: () => AppThemeMode.system,
    );
  }
}

/// AppThemeMode 的轉換與顯示文字。
///
/// extension 可以把和 enum 相關的小邏輯集中在一起，
/// 避免 UI 或 repository 到處寫 switch。
extension AppThemeModeX on AppThemeMode {
  /// 儲存在 SharedPreferences 的穩定字串。
  String get storageValue => name;

  /// SettingsView 顯示給使用者看的文字。
  String get label {
    return switch (this) {
      AppThemeMode.system => '跟隨系統',
      AppThemeMode.light => '亮色模式',
      AppThemeMode.dark => '深色模式',
    };
  }

  /// 轉成 Flutter MaterialApp 使用的 ThemeMode。
  ThemeMode toThemeMode() {
    return switch (this) {
      AppThemeMode.system => ThemeMode.system,
      AppThemeMode.light => ThemeMode.light,
      AppThemeMode.dark => ThemeMode.dark,
    };
  }
}

/// 使用者偏好設定。
///
/// 目前只保存 themeMode，但用物件包起來是為了示範：
/// 當未來新增語言、字級或列表排序時，ViewModel 的 state 仍能維持一致。
class UserPreferences {
  const UserPreferences({
    this.themeMode = AppThemeMode.system,
  });

  /// 使用者選擇的主題模式。
  final AppThemeMode themeMode;

  /// 建立一份更新後的新偏好設定。
  ///
  /// immutable state 較適合 Riverpod，因為狀態變更會更明確。
  UserPreferences copyWith({
    AppThemeMode? themeMode,
  }) {
    return UserPreferences(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
