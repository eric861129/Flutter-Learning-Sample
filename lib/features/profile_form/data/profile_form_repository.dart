import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/profile_form_data.dart';

/// ProfileFormRepository 的 provider。
///
/// 表單頁透過這個抽象送出資料，測試時可以 override 成成功或失敗的 fake。
final profileFormRepositoryProvider = Provider<ProfileFormRepository>(
  (ref) => DemoProfileFormRepository(),
);

/// Profile Form feature 的資料入口抽象。
///
/// 即使目前只是 demo submit，也保留 repository 介面，
/// 讓初學者看到「表單 UI 不直接決定資料送去哪裡」的分層方式。
abstract class ProfileFormRepository {
  /// 送出個人資料表單。
  Future<void> submitProfile(ProfileFormData data);
}

/// Demo 用的表單送出實作。
///
/// 真實 app 可能會在這裡呼叫 API；教學專案先用短暫延遲模擬網路送出。
class DemoProfileFormRepository implements ProfileFormRepository {
  @override
  Future<void> submitProfile(ProfileFormData data) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }
}
