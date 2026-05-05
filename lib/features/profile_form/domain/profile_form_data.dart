/// 個人資料表單送出時使用的資料模型。
///
/// Form 裡的 TextEditingController 只存在 UI layer；
/// 真正交給 ViewModel / Repository 的資料會整理成這個不可變物件。
class ProfileFormData {
  const ProfileFormData({
    required this.name,
    required this.email,
    required this.password,
    this.bio = '',
  });

  /// 使用者姓名。
  final String name;

  /// 使用者 Email。
  final String email;

  /// 示範用密碼欄位。
  ///
  /// 真實產品不應把明文密碼長期保存在 app state。
  final String password;

  /// 個人簡介，示範選填欄位。
  final String bio;
}
