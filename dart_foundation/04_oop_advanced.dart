/// Dart 基礎學習 - 第四課：進階物件導向 (Advanced OOP)
/// 執行方式：在終端機輸入 `dart run dart_foundation/04_oop_advanced.dart`

/// Mixin：為類別添加功能，而不使用繼承。
///
/// Dart 只能單繼承，但可以混入多個 mixin。
/// Logger 示範把「紀錄訊息」能力抽出來重用。
mixin Logger {
  void log(String message) => print('[LOG] $message');
}

/// 驗證能力 mixin。
///
/// 這裡故意保持簡單，只示範 mixin 可以把可重用方法掛到 class 上。
mixin Validator {
  bool isValidEmail(String email) => email.contains('@');
}

/// 示範同時混入 Logger 與 Validator 的服務類別。
///
/// `with Logger, Validator` 表示 AuthService 擁有兩個 mixin 的方法。
class AuthService with Logger, Validator {
  void login(String email) {
    if (isValidEmail(email)) {
      log('User logged in with $email');
    } else {
      log('Invalid email address!');
    }
  }
}

/// Extension：擴充既有類別的功能。
///
/// 即使 String 是 Dart 內建類別，我們仍能透過 extension 加上語意化方法。
extension StringExtensions on String {
  /// 將字串第一個字母轉成大寫。
  String capitalize() {
    if (this.isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}

/// Sealed class：限制狀態子類別的集合。
///
/// 常用於 UI state，例如 initial/loading/success/failure。
/// 搭配 switch expression 時，編譯器能提醒你是否漏處理狀態。
sealed class AuthState {}

/// 尚未開始登入。
class AuthInitial extends AuthState {}

/// 登入進行中。
class AuthLoading extends AuthState {}

/// 登入成功。
class AuthSuccess extends AuthState {
  final String userName;
  AuthSuccess(this.userName);
}

/// 登入失敗。
class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
}

/// 將 AuthState 轉成畫面可以顯示的訊息。
///
/// 這裡示範 Dart 3 pattern matching。
String getMessage(AuthState state) {
  // 因為是 sealed，編譯器會檢查是否處理了所有子類別
  return switch (state) {
    AuthInitial() => '請登入',
    AuthLoading() => '加載中...',
    AuthSuccess(userName: var name) => '歡迎回來, $name',
    AuthFailure(error: var e) => '出錯了: $e',
  };
}

/// 進階物件導向範例入口。
void main() {
  print('--- 1. Mixin 測試 ---');
  var auth = AuthService();
  auth.login('eric@example.com');
  auth.login('wrong-email');

  print('\n--- 2. Extension 測試 ---');
  var name = 'flutter';
  print('原始: $name, 擴充後: ${name.capitalize()}');

  print('\n--- 3. Sealed Class & Pattern Matching ---');
  print(getMessage(AuthInitial()));
  print(getMessage(AuthSuccess('Eric')));

  print('\n--- 學習重點 ---');
  print('1. Mixin 讓代碼更容易重用。');
  print('2. Extension 讓你的代碼更具可讀性 (語義化)。');
  print('3. Sealed Classes 是處理 UI 狀態 (Loading/Success/Error) 的神兵利器。');
}
