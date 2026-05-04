# 架構總覽

本專案採用「小型教學專案可讀性」與「大型 app 可擴充性」之間的折衷架構。

## 核心原則

- `main.dart` 只負責啟動 app。
- `core/` 放 app 全域設定。
- `services/` 放跨 feature 共用的基礎服務。
- `features/<name>/` 放單一功能的 domain、data、presentation。
- View 只負責呈現 UI 與轉交事件。
- ViewModel 負責 UI state 與使用者事件。
- Repository 是 feature data 的來源入口。
- API service 負責 HTTP 與 JSON 轉換。
- 程式碼註解以繁體中文說明架構角色與學習重點，讓範例能直接作為教材閱讀。

## 目前目錄

```text
Flutter-Learning-Sample/
  dart_foundation/
  docs/
    features/
    governance/
    lessons/
  integration_test/
  lib/
    core/
      router.dart
      theme.dart
    features/
      posts/
        data/
          post_api_service.dart
          post_repository.dart
        domain/
          post.dart
        presentation/
          post_list_view.dart
          post_list_view_model.dart
    services/
      api_client.dart
      storage_service.dart
    views/
      home_page.dart
      ui_kit_view.dart
    main.dart
  test/
  analysis_options.yaml
  pubspec.yaml
```

## 目前套件基準

```yaml
environment:
  sdk: '>=3.9.0 <4.0.0'

dependencies:
  dio: ^5.9.2
  flutter_riverpod: ^3.3.1
  go_router: ^17.2.1
  shared_preferences: ^2.5.5

dev_dependencies:
  flutter_lints: ^6.0.0
```

## Data Flow

```text
PostListView
  -> PostListViewModel
  -> PostRepository
  -> PostApiService
  -> ApiClient
  -> JSONPlaceholder API
```

回傳方向：

```text
JSON
  -> Post domain model
  -> AsyncValue<List<Post>>
  -> PostListView renders loading/data/error
```

## 為什麼 posts 使用 feature-first

教學專案早期常用 `models/`、`services/`、`views/` 這種 layer-first 架構，初學者容易理解。但功能變多後，相關檔案會分散在不同資料夾。

`features/posts/` 將 posts 相關檔案放在一起，讓學習者可以一次看完整功能：

- data 如何取得資料
- domain model 如何定義
- ViewModel 如何轉成 UI state
- View 如何呈現狀態
- tests 如何用 fake repository 驗證行為

## 什麼時候新增 use case

目前 posts 的邏輯很小，ViewModel 直接呼叫 Repository 即可。若未來出現跨多個 repository 的流程，例如「登入後同步使用者、設定與離線快取」，就可以加入：

```text
features/<name>/domain/use_cases/
```

在那之前，先保持簡單。

## 開發習慣建議

- **Widget 拆分**：一個 Widget 只做一件事。
- **型別安全**：JSON 解析要做明確型別轉換，不要讓 `dynamic` 到處流動。
- **命名規範**：類別名用 `UpperCamelCase`，變數與檔案名用 `snake_case`。
- **可測試性**：外部依賴用建構子注入，例如 `PostApiService({ApiClient? apiClient})`。
- **文件同步**：教學文件中的套件版本與實作範例要和 `pubspec.yaml` 保持一致。
- **CI 驗證**：本機無法安裝 Flutter 時，至少用 GitHub Actions 跑 `flutter analyze` 與 `flutter test`。
