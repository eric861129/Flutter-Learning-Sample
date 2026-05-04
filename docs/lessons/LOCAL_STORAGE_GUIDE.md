# 本地儲存與快取指南 (Local Storage)

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
