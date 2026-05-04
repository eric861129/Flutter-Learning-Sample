import 'package:shared_preferences/shared_preferences.dart';

/// 本地儲存服務。
///
/// 使用 SharedPreferencesAsync 示範跨平台簡單 key-value 儲存。
/// 敏感資料如 access token 應改用 flutter_secure_storage。
class StorageService {
  /// 允許注入 SharedPreferencesAsync，方便未來測試或替換儲存實作。
  StorageService({SharedPreferencesAsync? preferences})
      : _preferences = preferences ?? SharedPreferencesAsync();

  final SharedPreferencesAsync _preferences;

  /// 儲存字串資料。
  ///
  /// 適合保存非敏感設定，例如使用者偏好的排序方式或主題選項。
  Future<void> saveString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  /// 讀取字串資料。
  ///
  /// 沒有資料時會回傳 null，呼叫端要決定預設值。
  Future<String?> getString(String key) async {
    return _preferences.getString(key);
  }

  /// 移除資料。
  ///
  /// 常見情境是清除使用者偏好或登出時清掉本地狀態。
  Future<void> remove(String key) async {
    await _preferences.remove(key);
  }
}
