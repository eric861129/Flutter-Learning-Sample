import 'package:flutter_learning_sample/features/posts/domain/post.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Post Model 測試', () {
    test('JSON 解析測試', () {
      // Arrange：模擬 API 回傳的一筆 JSON。
      final json = {
        'id': 1,
        'title': '測試標題',
        'body': '測試內容',
      };

      // Act：將 JSON 轉成強型別的 Post。
      final post = Post.fromJson(json);

      // Assert：確認每個欄位都有被正確解析。
      expect(post.id, 1);
      expect(post.title, '測試標題');
      expect(post.body, '測試內容');
    });

    test('屬性賦值測試', () {
      // 直接建立 const Post，示範 domain model 的基本用法。
      const post = Post(id: 99, title: 'Hello', body: 'World');
      expect(post.id, 99);
    });
  });
}
