import 'package:flutter/material.dart';
import 'package:flutter_learning_sample/features/posts/data/post_repository.dart';
import 'package:flutter_learning_sample/features/posts/domain/post.dart';
import 'package:flutter_learning_sample/features/posts/domain/post_query.dart';
import 'package:flutter_learning_sample/features/posts/presentation/post_list_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// 成功情境用的假 Repository。
///
/// Widget test 不應依賴真實網路，否則測試會慢、不穩定，
/// 也會讓 UI 測試失去「只測畫面」的焦點。
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

/// 失敗情境用的假 Repository。
///
/// 用它來測試畫面是否能正確呈現 error state。
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
        items: [Post(id: 1, title: 'First page', body: 'Body')],
        hasMore: true,
      );
    }

    return const PostPage(
      items: [Post(id: 2, title: 'Second page', body: 'Body')],
      hasMore: false,
    );
  }
}

void main() {
  group('PostListView', () {
    testWidgets('renders posts from the repository', (tester) async {
      // Arrange：用 ProviderScope.override 把真實 repository 換成 fake。
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            postRepositoryProvider.overrideWithValue(
              FakePostRepository(const [
                Post(id: 1, title: 'Feature first', body: 'Body text'),
              ]),
            ),
          ],
          child: const MaterialApp(home: PostListView()),
        ),
      );

      // pump 讓 Future/Provider 狀態有機會完成並重建畫面。
      await tester.pump();
      await tester.pump();

      // Assert：畫面應顯示 fake repository 提供的文章內容。
      expect(find.text('Feature first'), findsOneWidget);
      expect(find.text('Body text'), findsOneWidget);
    });

    testWidgets('keeps the list screen structure stable', (tester) async {
      // Arrange：準備兩筆資料，檢查畫面骨架是否維持穩定。
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            postRepositoryProvider.overrideWithValue(
              FakePostRepository(const [
                Post(id: 1, title: 'First post', body: 'First body'),
                Post(id: 2, title: 'Second post', body: 'Second body'),
              ]),
            ),
          ],
          child: const MaterialApp(home: PostListView()),
        ),
      );

      await tester.pump();
      await tester.pump();

      // Snapshot-style：不比對像素，而是固定重要 UI 結構。
      // 這種測試比 golden file 輕量，適合本專案的教學範例。
      expect(find.text('文章列表 (Riverpod + Dio)'), findsOneWidget);
      expect(find.byIcon(Icons.refresh), findsOneWidget);
      expect(find.byKey(const Key('posts_search_field')), findsOneWidget);
      expect(find.text('全部'), findsOneWidget);
      expect(find.text('標題'), findsOneWidget);
      expect(find.text('內文'), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(2));
      expect(find.byIcon(Icons.delete_outline), findsNWidgets(2));
      expect(find.text('First post'), findsOneWidget);
      expect(find.text('Second post'), findsOneWidget);
    });

    testWidgets('removes a post when delete is tapped', (tester) async {
      // Arrange：準備兩筆文章，稍後點擊第二筆的刪除按鈕。
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            postRepositoryProvider.overrideWithValue(
              FakePostRepository(const [
                Post(id: 1, title: 'Keep', body: 'Body'),
                Post(id: 2, title: 'Remove', body: 'Body'),
              ]),
            ),
          ],
          child: const MaterialApp(home: PostListView()),
        ),
      );

      await tester.pump();
      await tester.pump();

      // Act：點擊最後一個刪除 icon，也就是 Remove 那筆資料。
      await tester.tap(find.byIcon(Icons.delete_outline).last);
      await tester.pump();
      await tester.pump();

      // Assert：Keep 還在，Remove 已從畫面消失。
      expect(find.text('Keep'), findsOneWidget);
      expect(find.text('Remove'), findsNothing);
    });

    testWidgets('shows retry UI when loading fails', (tester) async {
      // Arrange：注入會丟出例外的 repository。
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            postRepositoryProvider.overrideWithValue(FailingPostRepository()),
          ],
          child: const MaterialApp(home: PostListView()),
        ),
      );

      await tester.pump();

      // Assert：畫面應進入 error state，並提供重試按鈕。
      expect(find.textContaining('出錯了:'), findsOneWidget);
      expect(find.text('重試'), findsOneWidget);
    });

    testWidgets('updates search query after debounce', (tester) async {
      final repository = FakePostRepository(const [
        Post(id: 1, title: 'Flutter search', body: 'Body'),
      ]);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            postRepositoryProvider.overrideWithValue(repository),
          ],
          child: const MaterialApp(home: PostListView()),
        ),
      );

      await tester.pump();
      await tester.pump();

      await tester.enterText(
        find.byKey(const Key('posts_search_field')),
        'flutter',
      );
      await tester.pump(const Duration(milliseconds: 350));
      await tester.pump();

      expect(repository.queries.last.searchTerm, 'flutter');
      expect(repository.queries.last.page, 1);
    });

    testWidgets('changes filter when filter chip is tapped', (tester) async {
      final repository = FakePostRepository(const [
        Post(id: 1, title: 'Flutter search', body: 'Body'),
      ]);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            postRepositoryProvider.overrideWithValue(repository),
          ],
          child: const MaterialApp(home: PostListView()),
        ),
      );

      await tester.pump();
      await tester.pump();

      await tester.tap(find.text('標題'));
      await tester.pump();
      await tester.pump();

      expect(repository.queries.last.filter, PostSearchFilter.title);
    });

    testWidgets('loads more posts from the next page', (tester) async {
      final repository = PagingPostRepository();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            postRepositoryProvider.overrideWithValue(repository),
          ],
          child: const MaterialApp(home: PostListView()),
        ),
      );

      await tester.pump();
      await tester.pump();

      await tester.tap(find.text('載入更多'));
      await tester.pump();
      await tester.pump();

      expect(find.text('First page'), findsOneWidget);
      expect(find.text('Second page'), findsOneWidget);
      expect(repository.queries.map((query) => query.page), [1, 2]);
    });
  });
}
