import 'package:flutter_learning_sample/features/posts/data/post_api_service.dart';
import 'package:flutter_learning_sample/features/posts/data/post_repository.dart';
import 'package:flutter_learning_sample/features/posts/domain/post.dart';
import 'package:flutter_learning_sample/features/posts/domain/post_query.dart';
import 'package:flutter_test/flutter_test.dart';

/// 測試用的假 API service。
///
/// Repository test 的重點是驗證 Repository 行為，
/// 不應該真的打網路，所以用 fake service 提供固定資料。
class FakePostApiService extends PostApiService {
  FakePostApiService(this.posts);

  final List<Post> posts;

  @override
  Future<List<Post>> getPosts() async {
    return posts;
  }
}

void main() {
  group('RemotePostRepository', () {
    test('fetchPosts returns posts from PostApiService', () async {
      // Arrange：準備 API service 預期回傳的資料。
      const expectedPosts = [
        Post(id: 1, title: 'Flutter', body: 'Learning sample'),
      ];
      final repository = RemotePostRepository(
        apiService: FakePostApiService(expectedPosts),
      );

      // Act：透過 repository 取得資料。
      final posts = await repository.fetchPosts();

      // Assert：確認 repository 回傳 service 提供的資料。
      expect(posts, expectedPosts);
    });

    test('fetchPostPage filters posts by title', () async {
      final repository = RemotePostRepository(
        apiService: FakePostApiService(const [
          Post(id: 1, title: 'Flutter basics', body: 'Widget tree'),
          Post(id: 2, title: 'Riverpod state', body: 'Flutter state'),
        ]),
      );

      final page = await repository.fetchPostPage(
        const PostQuery(
          searchTerm: 'flutter',
          filter: PostSearchFilter.title,
        ),
      );

      expect(page.items.map((post) => post.id), [1]);
      expect(page.hasMore, isFalse);
    });

    test('fetchPostPage filters posts by body', () async {
      final repository = RemotePostRepository(
        apiService: FakePostApiService(const [
          Post(id: 1, title: 'Flutter basics', body: 'Widget tree'),
          Post(id: 2, title: 'Riverpod state', body: 'Flutter state'),
        ]),
      );

      final page = await repository.fetchPostPage(
        const PostQuery(
          searchTerm: 'flutter',
          filter: PostSearchFilter.body,
        ),
      );

      expect(page.items.map((post) => post.id), [2]);
      expect(page.hasMore, isFalse);
    });

    test('fetchPostPage paginates filtered results', () async {
      final repository = RemotePostRepository(
        apiService: FakePostApiService(const [
          Post(id: 1, title: 'One', body: 'Body'),
          Post(id: 2, title: 'Two', body: 'Body'),
          Post(id: 3, title: 'Three', body: 'Body'),
        ]),
      );

      final firstPage = await repository.fetchPostPage(
        const PostQuery(page: 1, pageSize: 2),
      );
      final secondPage = await repository.fetchPostPage(
        const PostQuery(page: 2, pageSize: 2),
      );

      expect(firstPage.items.map((post) => post.id), [1, 2]);
      expect(firstPage.hasMore, isTrue);
      expect(secondPage.items.map((post) => post.id), [3]);
      expect(secondPage.hasMore, isFalse);
    });
  });
}
