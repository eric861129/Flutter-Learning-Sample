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
- `test/features/settings/data/settings_repository_test.dart`
- `test/features/settings/presentation/settings_view_model_test.dart`
- `test/features/profile_form/data/profile_form_repository_test.dart`
- `test/features/profile_form/presentation/profile_form_validators_test.dart`
- `test/features/profile_form/presentation/profile_form_view_model_test.dart`

### Widget Test

適合：

- UI 是否顯示正確文字
- button tap 是否觸發預期畫面變化
- loading/error/data state 是否正確呈現
- snapshot-style UI 結構檢查

目前範例：

- `test/widget_test.dart`
- `test/features/posts/presentation/post_list_view_test.dart`
- `test/features/settings/presentation/settings_view_test.dart`
- `test/features/profile_form/presentation/profile_form_view_test.dart`

本專案目前使用輕量 snapshot-style 檢查，而不是 golden file：

- Posts widget test 固定 app bar、refresh button、list tile、delete button 結構。
- Settings widget test 固定頁面標題、主題模式區塊與三個 radio option。

這種測試不比對像素，因此比較不容易受到字型、平台或截圖環境影響；但仍能保護教學範例的主要 UI 骨架。

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

  @override
  Future<PostPage> fetchPostPage(PostQuery query) async {
    return PostPage(items: posts, hasMore: false);
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
flutter test --coverage
flutter test integration_test
```

## Coverage 報告

GitHub Actions 會執行 `flutter test --coverage`，並把 `coverage/lcov.info` 上傳成 artifact。

coverage 在本專案的用途不是追求 100%，而是幫助檢查：

- 新 feature 是否有測到 repository、ViewModel、widget。
- 文件宣稱的學習重點是否真的有對應測試。
- 重構時是否意外移除重要範例的保護網。

本機沒有 Flutter 時：

- 使用 `rg` 檢查文件與 import 一致性。
- 推到 GitHub 後查看 Actions 結果。
