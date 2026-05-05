import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/profile_form_repository.dart';
import '../domain/profile_form_data.dart';

/// Profile Form submit 狀態。
///
/// 表單送出和一般資料列表不同：它需要明確表示「正在送出」、
/// 「送出成功」與「送出失敗」。
class ProfileFormSubmissionState {
  const ProfileFormSubmissionState({
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  /// 是否正在送出。
  final bool isSubmitting;

  /// 是否送出成功。
  final bool isSuccess;

  /// 送出失敗時顯示給 UI 的錯誤訊息。
  final String? errorMessage;
}

/// ProfileFormViewModel 的 provider。
///
/// Notifier 適合管理表單 submit 這種同步 state + async action 的組合。
final profileFormViewModelProvider =
    NotifierProvider<ProfileFormViewModel, ProfileFormSubmissionState>(
  ProfileFormViewModel.new,
);

/// 個人資料表單的 ViewModel。
///
/// ViewModel 不做欄位驗證；欄位驗證由 Form/validator 負責。
/// ViewModel 只處理送出流程與 submit state。
class ProfileFormViewModel extends Notifier<ProfileFormSubmissionState> {
  @override
  ProfileFormSubmissionState build() {
    return const ProfileFormSubmissionState();
  }

  /// 送出表單。
  ///
  /// UI 會先呼叫 `FormState.validate()`；通過後才把整理好的資料交給這裡。
  Future<void> submit(ProfileFormData data) async {
    state = const ProfileFormSubmissionState(isSubmitting: true);

    try {
      await ref.read(profileFormRepositoryProvider).submitProfile(data);
      state = const ProfileFormSubmissionState(isSuccess: true);
    } on Object catch (error) {
      state = ProfileFormSubmissionState(
        errorMessage: '送出失敗：$error',
      );
    }
  }
}
