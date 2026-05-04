# 測試策略

本專案的測試目標是讓每個範例都能被安全修改。測試不是為了追求覆蓋率數字，而是保護教學重點不被破壞。

## 測試層級

### Unit Test

適合：

- domain model
- repository
- pure Dart logic
- ViewModel state transition

目前範例：

- `test/unit_test.dart`
- `test/features/posts/data/post_repository_test.dart`
- `test/features/posts/presentation/post_list_view_model_test.dart`

### Widget Test

適合：

- UI 是否顯示正確文字
- button tap 是否觸發預期畫面變化
- loading/error/data state 是否正確呈現

目前範例：

- `test/widget_test.dart`
- `test/features/posts/presentation/post_list_view_test.dart`

### Integration Test

適合：

- 驗證 app 是否能啟動
- 驗證主要頁面流程
- 驗證多個 widget 組合後的行為

目前範例：

- `integration_test/app_test.dart`

## Fake Repository 原則

Widget test 不應依賴真實網路。Posts feature 使用 fake repository：

```dart
class FakePostRepository implements PostRepository {
  FakePostRepository(this.posts);

  final List<Post> posts;

  @override
  Future<List<Post>> fetchPosts() async {
    return posts;
  }
}
```

測試透過 Riverpod override 注入 fake：

```dart
ProviderScope(
  overrides: [
    postRepositoryProvider.overrideWithValue(
      FakePostRepository(posts),
    ),
  ],
  child: const MaterialApp(home: PostListView()),
)
```

## 建議驗證指令

在有 Flutter 的環境：

```bash
flutter pub get
flutter analyze
flutter test
flutter test integration_test
```

本機沒有 Flutter 時：

- 使用 `rg` 檢查文件與 import 一致性。
- 推到 GitHub 後查看 Actions 結果。
