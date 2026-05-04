import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/post_repository.dart';
import '../domain/post.dart';

/// PostListViewModel 的 provider。
///
/// AsyncNotifierProvider 會自動把非同步資料包成 AsyncValue，
/// UI 就能統一處理 loading、data、error 三種狀態。
final postListViewModelProvider =
    AsyncNotifierProvider<PostListViewModel, List<Post>>(
  PostListViewModel.new,
);

/// 文章列表畫面的 ViewModel。
///
/// ViewModel 的職責是管理 UI state 與畫面事件。
/// 它會呼叫 Repository 取得資料，但不碰 Dio、不解析 JSON。
class PostListViewModel extends AsyncNotifier<List<Post>> {
  @override
  Future<List<Post>> build() {
    // build 是 AsyncNotifier 的初始載入點。
    // ref.read repository provider，讓資料來源可以在測試中被 override。
    return ref.read(postRepositoryProvider).fetchPosts();
  }

  /// 手動刷新文章列表。
  ///
  /// 先把 state 設成 loading，讓 UI 顯示載入狀態；
  /// 再用 AsyncValue.guard 自動把成功/失敗轉成 data/error。
  Future<void> refreshPosts() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(postRepositoryProvider).fetchPosts(),
    );
  }

  /// 從目前 UI state 中移除指定文章。
  ///
  /// 這裡是教學用的「本地刪除」範例，不會呼叫遠端 API。
  /// 若未來要真的刪除伺服器資料，應該新增 repository 方法。
  void deletePost(int id) {
    final posts = state.valueOrNull;
    if (posts == null) {
      // 如果目前不是 data 狀態，就不做本地刪除。
      return;
    }

    state = AsyncValue.data(
      posts.where((post) => post.id != id).toList(),
    );
  }
}
