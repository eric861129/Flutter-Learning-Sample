# 本地儲存與快取指南 (Local Storage)

本專案的完整實作範例位於 [../features/settings.md](../features/settings.md)，會示範如何用 `SharedPreferencesAsync` 保存使用者選擇的 `ThemeMode`，並讓 `MaterialApp` 即時套用設定。

APP 經常需要記住一些狀態（例如：用戶是否看過引導頁、主題偏好、Token）。在 Flutter 中，我們根據資料的複雜度選擇不同的儲存方式。

## 1. 輕量級儲存：`shared_preferences`
適合存儲簡單的鍵值對 (Key-Value)，如布林值、字串、數字。

### 常用場景：
- 使用者設定 (深色/淺色主題)
- 登入狀態標記
- 簡單的搜尋紀錄

### 使用範例：
```dart
import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  final prefs = SharedPreferencesAsync();

  // 寫入資料
  Future<void> saveThemeMode(bool isDarkMode) async {
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  // 讀取資料
  Future<bool> getThemeMode() async {
    return prefs.getBool('isDarkMode') ?? false; 
  }
}
```

本專案的實作位於 `lib/services/storage_service.dart`。

## 2. 加密儲存：`flutter_secure_storage`
適合存儲敏感資訊，它會使用 iOS 的 Keychain 與 Android 的 Keystore 來加密。

### 常用場景：
- JWT Access Token / Refresh Token
- 密碼
- 信用卡資訊 (不建議存本地，若必須則用此套件)

### 使用範例：
```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  final storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await storage.write(key: 'jwt_token', value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'jwt_token');
  }
}
```

## 3. 本地資料庫：`isar` 或 `sqflite` (進階)
當你需要存儲大量結構化資料，並且需要進行「搜尋」、「過濾」、「排序」時。
- **`isar`**：極速的 NoSQL 資料庫，支援全文檢索與多索引，是目前社群新寵。
- **`sqflite`**：傳統的關聯式資料庫，適合已經熟悉 SQL 語法的開發者。

## 學完你應該能回答

- `shared_preferences` 適合保存哪些資料？
- 為什麼 access token 不應該放在一般 SharedPreferences？
- `StorageService` 和 `SettingsRepository` 分層的好處是什麼？
- 什麼時候應該從 key-value storage 升級到本地資料庫？

## 最小修改練習

1. 在 Settings feature 新增一個「是否顯示教學提示」的 boolean 偏好。
2. 替新增偏好補 repository test。
3. 在 settings 頁面用 `SwitchListTile` 顯示這個偏好。

## 進階挑戰

1. 新增「重設所有偏好設定」功能。
2. 設計一個 `SecureStorageService` 介面，說明它和 `StorageService` 的差別。
3. 寫一份學習筆記，整理 Flutter 常見本地儲存方案的選擇時機。
