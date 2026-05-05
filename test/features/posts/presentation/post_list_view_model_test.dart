import 'package:flutter_learning_sample/features/posts/data/post_repository.dart';
import 'package:flutter_learning_sample/features/posts/domain/post.dart';
import 'package:flutter_learning_sample/features/posts/domain/post_query.dart';
import 'package:flutter_learning_sample/features/posts/presentation/post_list_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// 測試用的假 Repository。
///
/// ViewModel test 只關心 UI state 如何變化，
/// 因此不需要真的呼叫 API 或 PostApiService。
class FakePostRepository implements PostRepository {
  FakePostRepository(this.posts);

  final List<Post> posts;
  final List<PostQuery> queries = [];

  @override
  Future<List<Post>> fetchPosts() async {
    return posts;
  }

  @override
  Future<PostPage> fetchPostPage(PostQuery query) async {
    queries.add(query);
    return PostPage(items: posts, hasMore: false);
  }
}

class PagingPostRepository implements PostRepository {
  final List<PostQuery> queries = [];

  @override
  Future<List<Post>> fetchPosts() async {
    return const [];
  }

  @override
  Future<PostPage> fetchPostPage(PostQuery query) async {
    queries.add(query);
    if (query.page == 1) {
      return const PostPage(
        items: [Post(id: 1, title: 'Page 1', body: 'Body')],
        hasMore: true,
      );
    }

    return const PostPage(
      items: [Post(id: 2, title: 'Page 2', body: 'Body')],
      hasMore: false,
    );
  }
}

class FailingPostRepository implements PostRepository {
  @override
  Future<List<Post>> fetchPosts() async {
    throw Exception('network failed');
  }

  @override
  Future<PostPage> fetchPostPage(PostQuery query) async {
    throw Exception('network failed');
  }
}

void main() {
  group('PostListViewModel', () {
    test('loads posts from repository', () async {
      // Arrange：建立固定資料，並用 Riverpod override 注入 fake repository。
      const expectedPosts = [
        Post(id: 1, title: 'Official sample', body: 'Feature first'),
      ];
      final container = ProviderContainer(
        overrides: [
          postRepositoryProvider.overrideWithValue(
            FakePostRepository(expectedPosts),
          ),
        ],
      );
      addTearDown(container.dispose);

      // Act：讀取 provider 的 future 會觸發 ViewModel.build。
      final listState = await container.read(postListViewModelProvider.future);

      // Assert：確認 UI state 取得 fake repository 的資料。
      expect(listState.posts, expectedPosts);
    });

    test('deletePost removes an item from the current UI state', () async {
      // Arrange：先準備兩筆資料，稍後刪除 id = 2 的文章。
      const posts = [
        Post(id: 1, title: 'Keep', body: 'Body'),
        Post(id: 2, title: 'Remove', body: 'Body'),
      ];
      final container = ProviderContainer(
        overrides: [
          postRepositoryProvider.overrideWithValue(FakePostRepository(posts)),
        ],
      );
      addTearDown(container.dispose);

      // 先等待初始載入完成，讓 state 進入 data 狀態。
      await container.read(postListViewModelProvider.future);

      // Act：呼叫 ViewModel 的本地刪除事件。
      container.read(postListViewModelProvider.notifier).deletePost(2);

      // Assert：確認剩下的文章 id 只有 1。
      final state = container.read(postListViewModelProvider).value;
      expect(state?.posts.map((post) => post.id), [1]);
    });

    test('debounces search query before reloading first page', () async {
      final repository = FakePostRepository(const [
        Post(id: 1, title: 'Flutter search', body: 'Body'),
      ]);
      final container = ProviderContainer(
        overrides: [
          postRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);

      await container.read(postListViewModelProvider.future);

      container
          .read(postListViewModelProvider.notifier)
          .updateSearchTerm('flutter');

      expect(repository.queries.length, 1);

      await Future<void>.delayed(const Duration(milliseconds: 350));

      expect(repository.queries.length, 2);
      expect(repository.queries.last.searchTerm, 'flutter');
      expect(repository.queries.last.page, 1);
    });

    test('changing filter reloads the first page immediately', () async {
      final repository = FakePostRepository(const [
        Post(id: 1, title: 'Flutter search', body: 'Body'),
      ]);
      final container = ProviderContainer(
        overrides: [
          postRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);

      await container.read(postListViewModelProvider.future);

      await container
          .read(postListViewModelProvider.notifier)
          .changeFilter(PostSearchFilter.title);

      expect(repository.queries.last.filter, PostSearchFilter.title);
      expect(repository.queries.last.page, 1);
    });

    test('loadMore appends the next page', () async {
      final repository = PagingPostRepository();
      final container = ProviderContainer(
        overrides: [
          postRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);

      await container.read(postListViewModelProvider.future);

      await container.read(postListViewModelProvider.notifier).loadMore();

      final state = container.read(postListViewModelProvider).value;
      expect(state?.posts.map((post) => post.id), [1, 2]);
      expect(state?.hasMore, isFalse);
      expect(repository.queries.map((query) => query.page), [1, 2]);
    });

    test('retry reloads data after an interaction error', () async {
      final container = ProviderContainer(
        overrides: [
          postRepositoryProvider.overrideWithValue(FailingPostRepository()),
        ],
      );
      addTearDown(container.dispose);

      await expectLater(
        container.read(postListViewModelProvider.future),
        throwsException,
      );

      await container
          .read(postListViewModelProvider.notifier)
          .retryInitialLoad();

      expect(container.read(postListViewModelProvider).hasError, isTrue);
    });
  });
}
