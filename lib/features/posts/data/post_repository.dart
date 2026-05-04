import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/post.dart';
import 'post_api_service.dart';

/// PostApiService 的 Riverpod provider。
///
/// Provider 讓 service 的建立集中管理，也讓測試可以 override。
final postApiServiceProvider = Provider<PostApiService>(
  (ref) => PostApiService(),
);

/// PostRepository 的 Riverpod provider。
///
/// ViewModel 只依賴這個 provider，不直接建立 RemotePostRepository。
/// 測試時可以用 fake repository 取代它。
final postRepositoryProvider = Provider<PostRepository>(
  (ref) => RemotePostRepository(
    apiService: ref.watch(postApiServiceProvider),
  ),
);

/// Posts feature 的資料入口抽象。
///
/// 使用 abstract class 的好處：
/// - ViewModel 只依賴介面，不依賴遠端實作。
/// - 測試可以輕鬆建立 FakePostRepository。
/// - 未來可以加入 cache/local repository，而不改 presentation layer。
abstract class PostRepository {
  /// 取得文章列表。
  Future<List<Post>> fetchPosts();
}

/// 從遠端 API 取得文章資料的 repository 實作。
///
/// Repository 是 data layer 的「門面」：
/// 它目前只是轉呼叫 PostApiService，但未來可以在這裡加入快取、
/// retry、資料合併或離線同步。
class RemotePostRepository implements PostRepository {
  const RemotePostRepository({required PostApiService apiService})
      : _apiService = apiService;

  final PostApiService _apiService;

  @override
  Future<List<Post>> fetchPosts() {
    // 這裡保持簡單：資料來源只有遠端 API。
    // 若未來支援本地快取，仍會維持同一個 fetchPosts 介面。
    return _apiService.getPosts();
  }
}
