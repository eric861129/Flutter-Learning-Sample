/// Profile Form 的驗證規則。
///
/// 把 validator 從 Widget 中抽出來，可以讓驗證邏輯被 unit test 保護，
/// 也讓畫面程式碼更專注在 UI 結構。
class ProfileFormValidators {
  const ProfileFormValidators._();

  /// 驗證姓名必填。
  static String? name(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return '請輸入姓名';
    }
    return null;
  }

  /// 驗證 Email 必填且格式基本正確。
  static String? email(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return '請輸入 Email';
    }
    if (!text.contains('@') || !text.contains('.')) {
      return 'Email 格式不正確';
    }
    return null;
  }

  /// 驗證密碼必填且至少 8 碼。
  static String? password(String? value) {
    final text = value ?? '';
    if (text.isEmpty) {
      return '請輸入密碼';
    }
    if (text.length < 8) {
      return '密碼至少 8 碼';
    }
    return null;
  }
}
