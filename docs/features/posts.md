# Posts Feature Walkthrough

Posts 是本專案第一個完整 feature-first 範例。它示範如何用 Riverpod、Dio、Repository 與 ViewModel 建立可測試的資料列表頁，並加入搜尋、篩選、分頁載入與錯誤重試。

## 學習目標

讀完這個 feature 後，你應該能回答：

- 為什麼 View 不直接呼叫 Dio？
- Repository 在 feature 中負責什麼？
- ViewModel 如何管理 loading/data/error？
- 搜尋 debounce 為什麼應該放在 ViewModel，而不是直接塞在 Widget？
- 分頁載入和第一次載入的 UI state 有什麼差別？
- Widget test 如何用 fake repository 避免打真實 API？
- 為什麼 domain model 放在 `domain/`？

## 檔案地圖

```text
lib/features/posts/
  domain/
    post.dart
    post_query.dart
  data/
    post_api_service.dart
    post_repository.dart
  presentation/
    post_list_state.dart
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

`domain/post_query.dart` 定義列表查詢條件：

- `PostSearchFilter`：搜尋全部、標題或內文。
- `PostQuery`：搜尋字、篩選模式、頁碼、每頁筆數。
- `PostPage`：當頁資料與 `hasMore`。

## Data Layer

`post_api_service.dart` 負責呼叫 API 並把 JSON 轉成 `Post`。

`post_repository.dart` 是 feature data 的入口。ViewModel 依賴 `PostRepository` 這個抽象介面，不需要知道資料從哪裡來。

本範例使用「本地 filter + pagination」包裝 JSONPlaceholder 回傳的完整列表。這是教學專案的折衷：可以學到列表狀態與分頁 UI，又不被遠端 API 是否支援分頁限制。

```text
PostRepository
  -> RemotePostRepository
  -> PostApiService
  -> ApiClient
```

## Presentation Layer

`post_list_state.dart` 描述列表互動狀態：

- 目前文章
- 搜尋文字
- 篩選模式
- 目前頁碼與是否還有下一頁
- 是否正在刷新
- 是否正在載入更多
- 搜尋/刷新錯誤與載入更多錯誤

`post_list_view_model.dart` 使用 `AsyncNotifier<PostListState>` 管理：

- 初始載入 loading / data / error
- `updateSearchTerm` 的 debounce
- `changeFilter` 的第一頁重載
- `loadMore` 的下一頁 append
- `refreshPosts` 與 `retryInitialLoad`

`post_list_view.dart` 呈現：

- 搜尋欄位
- filter chips
- 文章列表
- 載入更多按鈕
- inline error 與重試按鈕

## 測試設計

Repository test：

- 用 `FakePostApiService`
- 驗證 repository 會回傳 API service 的 posts
- 驗證依 title / body 搜尋
- 驗證 page / pageSize 與 `hasMore`

ViewModel test：

- 用 `ProviderContainer`
- override `postRepositoryProvider`
- 驗證載入資料、本地刪除、debounce、filter、load more、retry

Widget test：

- 用 `ProviderScope(overrides: [...])`
- 注入 fake repository
- 驗證畫面文字、搜尋欄、filter chips、刪除按鈕、載入更多、錯誤 UI

## 學完你應該能回答

- Posts feature 的 `domain`、`data`、`presentation` 各自放什麼？
- 為什麼 ViewModel 依賴 `PostRepository`，而不是直接依賴 `PostApiService`？
- `AsyncValue<PostListState>` 如何對應到初始 loading、data、error UI？
- 為什麼載入更多不應該把整個畫面切回 full-screen loading？
- debounce 如何降低不必要的列表重載？
- Widget test 如何用 fake repository 驗證畫面，而不打真實 API？

## 最小修改練習

1. 修改每頁筆數，觀察 `hasMore` 和「載入更多」按鈕如何變化。
2. 新增 post detail route：點擊文章後用 `go_router` 前往詳細頁。
3. 補一個 widget test，驗證搜尋沒有結果時會顯示空列表 UI。

## 進階挑戰

1. 新增 repository cache：第一次載入後暫存 posts。
2. 將 JSONPlaceholder API 換成自己的 API。
3. 將本地 pagination 改成 server-side pagination，並保留同一個 ViewModel API。
