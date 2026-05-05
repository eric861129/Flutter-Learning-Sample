# Settings Feature Walkthrough

Settings 是本專案第二個完整 feature-first 範例。它示範如何用 SharedPreferences 保存使用者偏好，並讓 `MaterialApp` 依照使用者選擇切換 `ThemeMode`。

## 學習目標

讀完這個 feature 後，你應該能回答：

- 為什麼使用者偏好設定適合放在本地 key-value storage？
- `ThemeMode.system`、`ThemeMode.light`、`ThemeMode.dark` 差在哪裡？
- Repository 如何把 SharedPreferences 的字串轉成 domain model？
- ViewModel 如何讓設定頁和 App shell 共用同一份狀態？
- Widget test 如何用 fake repository 避免依賴真實 SharedPreferences？

## 檔案地圖

```text
lib/features/settings/
  domain/
    user_preferences.dart
  data/
    settings_repository.dart
  presentation/
    settings_view_model.dart
    settings_view.dart
```

測試：

```text
test/features/settings/
  data/settings_repository_test.dart
  presentation/settings_view_model_test.dart
  presentation/settings_view_test.dart
```

## Domain

`domain/user_preferences.dart` 定義兩個核心概念：

- `AppThemeMode`：使用者可選的主題模式。
- `UserPreferences`：使用者偏好設定 state。

這裡不讓 UI 直接使用儲存用字串，例如 `dark` 或 `light`。UI 使用有型別的 enum，repository 才負責和 SharedPreferences 字串互轉。

## Data Layer

`settings_repository.dart` 定義 `SettingsRepository` 抽象與 `LocalSettingsRepository` 實作。

```text
SettingsRepository
  -> LocalSettingsRepository
  -> StorageService
  -> SharedPreferencesAsync
```

Repository 的重點是隔離儲存細節：

- ViewModel 不知道 key 名稱。
- ViewModel 不知道 SharedPreferences API。
- 測試可以用 fake repository 或 fake storage service。

## Presentation Layer

`settings_view_model.dart` 使用 `AsyncNotifier<UserPreferences>`：

- `build()`：載入目前偏好設定。
- `setThemeMode()`：保存新的主題模式並更新 UI state。

`settings_view.dart` 使用 `RadioListTile<AppThemeMode>` 顯示三種主題模式：

- 跟隨系統
- 亮色模式
- 深色模式

## App Shell 如何套用設定

`lib/main.dart` 的 `MyApp` 是 `ConsumerWidget`，會監聽 `settingsViewModelProvider`。

```text
SettingsView
  -> SettingsViewModel.setThemeMode
  -> SettingsRepository.saveThemeMode
  -> StorageService.saveString
  -> MyApp rebuild
  -> MaterialApp.router(themeMode: ...)
```

這代表使用者在設定頁切換主題後，整個 app shell 會立即套用新的 `ThemeMode`。

## 測試設計

Repository test：

- 用 `FakeStorageService`
- 驗證沒有資料時預設為 `AppThemeMode.system`
- 驗證儲存後能讀回使用者選擇

ViewModel test：

- 用 `ProviderContainer`
- override `settingsRepositoryProvider`
- 驗證初始載入與切換主題行為

Widget test：

- 用 `ProviderScope(overrides: [...])`
- 注入 fake repository
- 驗證三個主題選項有顯示
- 驗證點擊後會保存選擇

## 學完你應該能回答

- 使用者偏好設定為什麼適合用 key-value storage？
- `AppThemeMode` 和 Flutter 內建 `ThemeMode` 的關係是什麼？
- `SettingsRepository` 如何隔離 SharedPreferences 細節？
- `MyApp` 為什麼要監聽 `settingsViewModelProvider`？

## 最小修改練習

1. 新增字級設定：小、標準、大。
2. 新增語言設定：繁體中文、英文。
3. 在首頁顯示目前主題模式。

## 進階挑戰

1. 新增「重設所有偏好」按鈕。
2. 把 Settings feature 的偏好設定同步到雲端帳號。
3. 補 accessibility 語意與大字體測試，確認設定頁更接近成熟 app。
