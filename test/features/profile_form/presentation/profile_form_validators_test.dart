import 'package:flutter_learning_sample/features/profile_form/presentation/profile_form_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProfileFormValidators', () {
    test('validates required name', () {
      expect(ProfileFormValidators.name(''), '請輸入姓名');
      expect(ProfileFormValidators.name('Eric'), isNull);
    });

    test('validates email format', () {
      expect(ProfileFormValidators.email(''), '請輸入 Email');
      expect(ProfileFormValidators.email('not-email'), 'Email 格式不正確');
      expect(ProfileFormValidators.email('eric@example.com'), isNull);
    });

    test('validates password length', () {
      expect(ProfileFormValidators.password(''), '請輸入密碼');
      expect(ProfileFormValidators.password('1234567'), '密碼至少 8 碼');
      expect(ProfileFormValidators.password('12345678'), isNull);
    });
  });
}
