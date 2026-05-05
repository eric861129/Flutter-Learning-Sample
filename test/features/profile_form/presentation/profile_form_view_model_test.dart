import 'package:flutter_learning_sample/features/profile_form/data/profile_form_repository.dart';
import 'package:flutter_learning_sample/features/profile_form/domain/profile_form_data.dart';
import 'package:flutter_learning_sample/features/profile_form/presentation/profile_form_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class SuccessfulProfileFormRepository implements ProfileFormRepository {
  ProfileFormData? submittedData;

  @override
  Future<void> submitProfile(ProfileFormData data) async {
    submittedData = data;
  }
}

class FailingProfileFormRepository implements ProfileFormRepository {
  @override
  Future<void> submitProfile(ProfileFormData data) async {
    throw Exception('submit failed');
  }
}

void main() {
  group('ProfileFormViewModel', () {
    test('submits valid data and enters success state', () async {
      final repository = SuccessfulProfileFormRepository();
      final container = ProviderContainer(
        overrides: [
          profileFormRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);

      const data = ProfileFormData(
        name: 'Eric',
        email: 'eric@example.com',
        password: '12345678',
        bio: 'Learning Flutter',
      );

      await container.read(profileFormViewModelProvider.notifier).submit(data);

      final state = container.read(profileFormViewModelProvider);
      expect(repository.submittedData, data);
      expect(state.isSuccess, isTrue);
      expect(state.isSubmitting, isFalse);
      expect(state.errorMessage, isNull);
    });

    test('shows error state when submission fails', () async {
      final container = ProviderContainer(
        overrides: [
          profileFormRepositoryProvider.overrideWithValue(
            FailingProfileFormRepository(),
          ),
        ],
      );
      addTearDown(container.dispose);

      const data = ProfileFormData(
        name: 'Eric',
        email: 'eric@example.com',
        password: '12345678',
      );

      await container.read(profileFormViewModelProvider.notifier).submit(data);

      final state = container.read(profileFormViewModelProvider);
      expect(state.isSuccess, isFalse);
      expect(state.isSubmitting, isFalse);
      expect(state.errorMessage, contains('submit failed'));
    });
  });
}
