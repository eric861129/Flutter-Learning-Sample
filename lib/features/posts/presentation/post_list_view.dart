import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
            // 使用者點擊刷新時，事件交給 ViewModel，不在 View 裡處理資料邏輯。
            onPressed: () => ref
                .read(postListViewModelProvider.notifier)
                .refreshPosts(),
          ),
        ],
      ),
      body: postsAsync.when(
        // data：資料載入成功，顯示文章清單。
        data: (posts) => RefreshIndicator(
          onRefresh: () => ref
              .read(postListViewModelProvider.notifier)
              .refreshPosts(),
          child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return ListTile(
                title: Text(
                  post.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(post.body, maxLines: 2),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  // 這是本地刪除範例，實際刪除邏輯集中在 ViewModel。
                  onPressed: () => ref
                      .read(postListViewModelProvider.notifier)
                      .deletePost(post.id),
                ),
                onTap: () => _showDetail(context, post.body),
              );
            },
          ),
        ),
        // loading：第一次載入或手動刷新時顯示進度圈。
        loading: () => const Center(child: CircularProgressIndicator()),
        // error：把錯誤狀態轉成可理解的畫面，並提供重試入口。
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('出錯了: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                // invalidate 會清掉 provider 狀態並重新觸發 build。
                onPressed: () => ref.invalidate(postListViewModelProvider),
                child: const Text('重試'),
              ),
            ],
          ),
        ),
      ),
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
