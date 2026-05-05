import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_learning_sample/features/profile_form/data/profile_form_repository.dart';
import 'package:flutter_learning_sample/features/profile_form/domain/profile_form_data.dart';
import 'package:flutter_learning_sample/features/profile_form/presentation/profile_form_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class ControlledProfileFormRepository implements ProfileFormRepository {
  final Completer<void> completer = Completer<void>();
  ProfileFormData? submittedData;

  @override
  Future<void> submitProfile(ProfileFormData data) {
    submittedData = data;
    return completer.future;
  }
}

class FailingProfileFormRepository implements ProfileFormRepository {
  @override
  Future<void> submitProfile(ProfileFormData data) async {
    throw Exception('server rejected form');
  }
}

void main() {
  group('ProfileFormView', () {
    testWidgets('shows validator messages when submitting empty form',
        (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: ProfileFormView()),
        ),
      );

      await tester.tap(find.text('送出'));
      await tester.pump();

      expect(find.text('請輸入姓名'), findsOneWidget);
      expect(find.text('請輸入 Email'), findsOneWidget);
      expect(find.text('請輸入密碼'), findsOneWidget);
    });

    testWidgets('shows loading state while submitting valid form',
        (tester) async {
      final repository = ControlledProfileFormRepository();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            profileFormRepositoryProvider.overrideWithValue(repository),
          ],
          child: const MaterialApp(home: ProfileFormView()),
        ),
      );

      await tester.enterText(
        find.byKey(const Key('profile_name_field')),
        'Eric',
      );
      await tester.enterText(
        find.byKey(const Key('profile_email_field')),
        'eric@example.com',
      );
      await tester.enterText(
        find.byKey(const Key('profile_password_field')),
        '12345678',
      );

      await tester.tap(find.text('送出'));
      await tester.pump();

      expect(find.text('送出中...'), findsOneWidget);
      expect(repository.submittedData?.email, 'eric@example.com');

      repository.completer.complete();
      await tester.pump();
      await tester.pump();

      expect(find.text('表單已送出'), findsOneWidget);
    });

    testWidgets('shows error display when submission fails', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            profileFormRepositoryProvider.overrideWithValue(
              FailingProfileFormRepository(),
            ),
          ],
          child: const MaterialApp(home: ProfileFormView()),
        ),
      );

      await tester.enterText(
        find.byKey(const Key('profile_name_field')),
        'Eric',
      );
      await tester.enterText(
        find.byKey(const Key('profile_email_field')),
        'eric@example.com',
      );
      await tester.enterText(
        find.byKey(const Key('profile_password_field')),
        '12345678',
      );

      await tester.tap(find.text('送出'));
      await tester.pump();
      await tester.pump();

      expect(find.textContaining('送出失敗'), findsOneWidget);
    });
  });
}
