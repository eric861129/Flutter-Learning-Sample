import '../domain/post.dart';
import '../domain/post_query.dart';

/// 文章列表畫面的 UI state。
///
/// 教學重點：
/// - AsyncValue 負責「第一次載入」的 loading/data/error。
/// - 進入 data 後，列表互動狀態放在這個 state object。
/// - 搜尋、分頁、載入更多錯誤都集中管理，View 就不用自己拼狀態。
class PostListState {
  const PostListState({
    required this.posts,
    required this.query,
    required this.hasMore,
    this.isRefreshing = false,
    this.isLoadingMore = false,
    this.errorMessage,
    this.loadMoreErrorMessage,
  });

  final List<Post> posts;
  final PostQuery query;
  final bool hasMore;
  final bool isRefreshing;
  final bool isLoadingMore;
  final String? errorMessage;
  final String? loadMoreErrorMessage;

  PostListState copyWith({
    List<Post>? posts,
    PostQuery? query,
    bool? hasMore,
    bool? isRefreshing,
    bool? isLoadingMore,
    String? errorMessage,
    String? loadMoreErrorMessage,
    bool clearErrorMessage = false,
    bool clearLoadMoreErrorMessage = false,
  }) {
    return PostListState(
      posts: posts ?? this.posts,
      query: query ?? this.query,
      hasMore: hasMore ?? this.hasMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage:
          clearErrorMessage ? null : errorMessage ?? this.errorMessage,
      loadMoreErrorMessage: clearLoadMoreErrorMessage
          ? null
          : loadMoreErrorMessage ?? this.loadMoreErrorMessage,
    );
  }
}
