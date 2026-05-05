import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/post.dart';
import '../domain/post_query.dart';
import 'post_list_state.dart';
import 'post_list_view_model.dart';

/// 文章列表畫面。
///
/// 這一層是 View，只負責：
/// - 監聽 ViewModel 的 state。
/// - 依 loading/data/error 呈現不同 UI。
/// - 把使用者事件轉交給 ViewModel。
class PostListView extends ConsumerWidget {
  const PostListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watch 會訂閱 provider；當文章列表狀態改變時，畫面會自動重建。
    final postsAsync = ref.watch(postListViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('文章列表 (Riverpod + Dio)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: '重新整理',
            // 使用者點擊刷新時，事件交給 ViewModel，不在 View 裡處理資料邏輯。
            onPressed: () => ref
                .read(postListViewModelProvider.notifier)
                .refreshPosts(),
          ),
        ],
      ),
      body: postsAsync.when(
        // data：資料載入成功，顯示搜尋、篩選、列表與分頁控制。
        data: (listState) => _PostListContent(state: listState),
        // loading：第一次載入時顯示進度圈。
        loading: () => const Center(child: CircularProgressIndicator()),
        // error：初始載入失敗時，提供重試入口。
        error: (error, stack) => _InitialErrorView(error: error),
      ),
    );
  }
}

class _PostListContent extends ConsumerWidget {
  const _PostListContent({required this.state});

  final PostListState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(postListViewModelProvider.notifier);

    return RefreshIndicator(
      onRefresh: viewModel.refreshPosts,
      child: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              key: const Key('posts_search_field'),
              decoration: const InputDecoration(
                labelText: '搜尋文章',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: viewModel.updateSearchTerm,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              children: [
                _FilterChip(
                  label: '全部',
                  filter: PostSearchFilter.all,
                  selectedFilter: state.query.filter,
                ),
                _FilterChip(
                  label: '標題',
                  filter: PostSearchFilter.title,
                  selectedFilter: state.query.filter,
                ),
                _FilterChip(
                  label: '內文',
                  filter: PostSearchFilter.body,
                  selectedFilter: state.query.filter,
                ),
              ],
            ),
          ),
          if (state.isRefreshing)
            const LinearProgressIndicator(key: Key('posts_refreshing_bar')),
          if (state.errorMessage != null)
            _InlineErrorMessage(
              message: state.errorMessage!,
              onRetry: viewModel.refreshPosts,
            ),
          if (state.posts.isEmpty && !state.isRefreshing)
            const _EmptyPostsView()
          else
            ...state.posts.map(
              (post) => _PostListTile(post: post),
            ),
          _PaginationFooter(state: state),
        ],
      ),
    );
  }
}

class _FilterChip extends ConsumerWidget {
  const _FilterChip({
    required this.label,
    required this.filter,
    required this.selectedFilter,
  });

  final String label;
  final PostSearchFilter filter;
  final PostSearchFilter selectedFilter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilterChip(
      label: Text(label),
      selected: selectedFilter == filter,
      onSelected: (_) => ref
          .read(postListViewModelProvider.notifier)
          .changeFilter(filter),
    );
  }
}

class _PostListTile extends ConsumerWidget {
  const _PostListTile({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(
        post.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(post.body, maxLines: 2),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        tooltip: '刪除文章',
        // 這是本地刪除範例，實際刪除邏輯集中在 ViewModel。
        onPressed: () => ref
            .read(postListViewModelProvider.notifier)
            .deletePost(post.id),
      ),
      onTap: () => _showDetail(context, post.body),
    );
  }

  /// 用 bottom sheet 顯示文章內文。
  ///
  /// 這是 UI-only 行為，不涉及資料層，因此可以留在 View 中。
  void _showDetail(BuildContext context, String body) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Text(body, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}

class _PaginationFooter extends ConsumerWidget {
  const _PaginationFooter({required this.state});

  final PostListState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(postListViewModelProvider.notifier);

    if (state.isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.loadMoreErrorMessage != null) {
      return _InlineErrorMessage(
        message: state.loadMoreErrorMessage!,
        onRetry: viewModel.loadMore,
      );
    }

    if (!state.hasMore) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: Text('已載入全部文章')),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: OutlinedButton.icon(
          icon: const Icon(Icons.expand_more),
          label: const Text('載入更多'),
          onPressed: viewModel.loadMore,
        ),
      ),
    );
  }
}

class _InlineErrorMessage extends StatelessWidget {
  const _InlineErrorMessage({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Material(
        color: Theme.of(context).colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(message)),
              TextButton(
                onPressed: onRetry,
                child: const Text('重試'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyPostsView extends StatelessWidget {
  const _EmptyPostsView();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(32),
      child: Center(child: Text('沒有符合條件的文章')),
    );
  }
}

class _InitialErrorView extends ConsumerWidget {
  const _InitialErrorView({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text('出錯了: $error'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => ref
                .read(postListViewModelProvider.notifier)
                .retryInitialLoad(),
            child: const Text('重試'),
          ),
        ],
      ),
    );
  }
}
