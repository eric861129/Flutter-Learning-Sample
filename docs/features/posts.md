# Posts Feature Walkthrough

Posts 是本專案第一個完整 feature-first 範例。它示範如何用 Riverpod、Dio、Repository 與 ViewModel 建立可測試的資料列表頁。

## 學習目標

讀完這個 feature 後，你應該能回答：

- 為什麼 View 不直接呼叫 Dio？
- Repository 在 feature 中負責什麼？
- ViewModel 如何管理 loading/data/error？
- Widget test 如何用 fake repository 避免打真實 API？
- 為什麼 domain model 放在 `domain/`？

## 檔案地圖

```text
lib/features/posts/
  domain/
    post.dart
  data/
    post_api_service.dart
    post_repository.dart
  presentation/
    post_list_view_model.dart
    post_list_view.dart
```

測試：

```text
test/features/posts/
  data/post_repository_test.dart
  presentation/post_list_view_model_test.dart
  presentation/post_list_view_test.dart
```

## Domain

`domain/post.dart` 定義 feature 內部使用的文章模型。

```dart
class Post {
  const Post({
    required this.id,
    required this.title,
    required this.body,
  });

  final int id;
  final String title;
  final String body;
}
```

重點：UI 和 ViewModel 使用 `Post`，而不是直接使用 `Map<String, dynamic>`。

## Data Layer

`post_api_service.dart` 負責呼叫 API 並把 JSON 轉成 `Post`。

`post_repository.dart` 是 feature data 的入口。ViewModel 依賴 `PostRepository` 這個抽象介面，不需要知道資料從哪裡來。

```text
PostRepository
  -> RemotePostRepository
  -> PostApiService
  -> ApiClient
```

## Presentation Layer

`post_list_view_model.dart` 使用 `AsyncNotifier<List<Post>>` 管理三種狀態：

- loading
- data
- error

`post_list_view.dart` 使用 `postsAsync.when(...)` 分別呈現：

- `CircularProgressIndicator`
- `ListView`
- 錯誤訊息與重試按鈕

## 測試設計

Repository test：

- 用 `FakePostApiService`
- 驗證 repository 會回傳 API service 的 posts

ViewModel test：

- 用 `ProviderContainer`
- override `postRepositoryProvider`
- 驗證載入資料與本地刪除行為

Widget test：

- 用 `ProviderScope(overrides: [...])`
- 注入 fake repository
- 驗證畫面文字、刪除按鈕、錯誤 UI

## 學完你應該能回答

- Posts feature 的 `domain`、`data`、`presentation` 各自放什麼？
- 為什麼 ViewModel 依賴 `PostRepository`，而不是直接依賴 `PostApiService`？
- `AsyncValue<List<Post>>` 如何對應到 loading、data、error UI？
- Widget test 如何用 fake repository 驗證畫面，而不打真實 API？

## 最小修改練習

1. 新增空列表 UI：當 posts 為空時顯示「目前沒有文章」。
2. 新增 post detail route：點擊文章後用 `go_router` 前往詳細頁。
3. 補一個 widget test，驗證空列表 UI。

## 進階挑戰

1. 新增 repository cache：第一次載入後暫存 posts。
2. 將 JSONPlaceholder API 換成自己的 API。
3. 加入 search、filter、pagination，讓 posts 變成更接近真實產品的列表頁。
