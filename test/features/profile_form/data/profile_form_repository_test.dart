import 'package:flutter_learning_sample/features/profile_form/data/profile_form_repository.dart';
import 'package:flutter_learning_sample/features/profile_form/domain/profile_form_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DemoProfileFormRepository', () {
    test('completes demo submission', () async {
      final repository = DemoProfileFormRepository();

      await expectLater(
        repository.submitProfile(
          const ProfileFormData(
            name: 'Eric',
            email: 'eric@example.com',
            password: '12345678',
          ),
        ),
        completes,
      );
    });
  });
}
