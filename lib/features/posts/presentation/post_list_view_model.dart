import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/post_repository.dart';
import '../domain/post_query.dart';
import 'post_list_state.dart';

/// PostListViewModel 的 provider。
///
/// AsyncNotifierProvider 會自動把第一次非同步載入包成 AsyncValue，
/// UI 就能統一處理 initial loading、data、initial error。
final postListViewModelProvider =
    AsyncNotifierProvider<PostListViewModel, PostListState>(
  PostListViewModel.new,
);

/// 文章列表畫面的 ViewModel。
///
/// ViewModel 的職責是管理 UI state 與畫面事件。
/// 這裡示範搜尋、debounce、filter、pagination、retry 的常見列表狀態。
class PostListViewModel extends AsyncNotifier<PostListState> {
  static const _initialQuery = PostQuery();
  static const _debounceDuration = Duration(milliseconds: 300);

  Timer? _searchDebounce;

  @override
  Future<PostListState> build() async {
    ref.onDispose(() => _searchDebounce?.cancel());

    return _loadInitialPage();
  }

  Future<PostListState> _loadInitialPage() async {
    final page = await ref.read(postRepositoryProvider).fetchPostPage(
          _initialQuery,
        );

    return PostListState(
      posts: page.items,
      query: _initialQuery,
      hasMore: page.hasMore,
    );
  }

  /// 手動刷新文章列表。
  ///
  /// refresh 會保留目前搜尋字與篩選條件，但回到第一頁重新載入。
  Future<void> refreshPosts() async {
    await _reloadFirstPage();
  }

  /// 初始載入失敗時使用的 retry。
  ///
  /// error state 沒有可沿用的 PostListState，因此直接讓 provider 重新進入
  /// loading，成功後再回到 data。
  Future<void> retryInitialLoad() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_loadInitialPage);
  }

  /// 更新搜尋文字。
  ///
  /// 使用 debounce 避免使用者每打一個字就立刻觸發查詢。
  void updateSearchTerm(String value) {
    final current = state.valueOrNull;
    if (current == null) {
      return;
    }

    final nextQuery = current.query.copyWith(
      searchTerm: value,
      page: 1,
    );

    state = AsyncValue.data(
      current.copyWith(
        query: nextQuery,
        clearErrorMessage: true,
        clearLoadMoreErrorMessage: true,
      ),
    );

    _searchDebounce?.cancel();
    _searchDebounce = Timer(_debounceDuration, () {
      _reloadFirstPage(query: nextQuery);
    });
  }

  /// 切換搜尋範圍。
  ///
  /// filter 是明確使用者操作，不需要 debounce，直接重載第一頁。
  Future<void> changeFilter(PostSearchFilter filter) async {
    final current = state.valueOrNull;
    if (current == null) {
      return;
    }

    await _reloadFirstPage(
      query: current.query.copyWith(
        filter: filter,
        page: 1,
      ),
    );
  }

  /// 載入下一頁。
  ///
  /// 這裡把「第一次載入」和「載入更多」分開處理：
  /// 第一次載入用 AsyncValue.loading；載入更多則保留原本列表並在底部顯示狀態。
  Future<void> loadMore() async {
    final current = state.valueOrNull;
    if (current == null || !current.hasMore || current.isLoadingMore) {
      return;
    }

    final nextQuery = current.query.copyWith(page: current.query.page + 1);
    state = AsyncValue.data(
      current.copyWith(
        isLoadingMore: true,
        clearLoadMoreErrorMessage: true,
      ),
    );

    try {
      final page = await ref.read(postRepositoryProvider).fetchPostPage(
            nextQuery,
          );

      final latest = state.valueOrNull ?? current;
      state = AsyncValue.data(
        latest.copyWith(
          posts: [...latest.posts, ...page.items],
          query: nextQuery,
          hasMore: page.hasMore,
          isLoadingMore: false,
          clearLoadMoreErrorMessage: true,
        ),
      );
    } on Object catch (error) {
      final latest = state.valueOrNull ?? current;
      state = AsyncValue.data(
        latest.copyWith(
          isLoadingMore: false,
          loadMoreErrorMessage: '載入更多失敗：$error',
        ),
      );
    }
  }

  /// 從目前 UI state 中移除指定文章。
  ///
  /// 這裡是教學用的「本地刪除」範例，不會呼叫遠端 API。
  /// 若未來要真的刪除伺服器資料，應該新增 repository 方法。
  void deletePost(int id) {
    final current = state.valueOrNull;
    if (current == null) {
      return;
    }

    state = AsyncValue.data(
      current.copyWith(
        posts: current.posts.where((post) => post.id != id).toList(),
      ),
    );
  }

  Future<void> _reloadFirstPage({PostQuery? query}) async {
    final current = state.valueOrNull;
    if (current == null) {
      await retryInitialLoad();
      return;
    }

    final nextQuery = (query ?? current.query).copyWith(page: 1);
    state = AsyncValue.data(
      current.copyWith(
        query: nextQuery,
        isRefreshing: true,
        clearErrorMessage: true,
        clearLoadMoreErrorMessage: true,
      ),
    );

    try {
      final page = await ref.read(postRepositoryProvider).fetchPostPage(
            nextQuery,
          );

      state = AsyncValue.data(
        current.copyWith(
          posts: page.items,
          query: nextQuery,
          hasMore: page.hasMore,
          isRefreshing: false,
          clearErrorMessage: true,
          clearLoadMoreErrorMessage: true,
        ),
      );
    } on Object catch (error) {
      final latest = state.valueOrNull ?? current;
      state = AsyncValue.data(
        latest.copyWith(
          isRefreshing: false,
          errorMessage: '載入文章失敗：$error',
        ),
      );
    }
  }
}
