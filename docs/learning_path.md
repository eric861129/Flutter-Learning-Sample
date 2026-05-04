# 學習路線

這條路線適合想用本專案系統性學 Flutter 的學習者。每一階段都包含「先理解概念，再看程式碼，再看測試」。

## Phase 0：專案地圖

先讀：

- `README.md`
- `docs/README.md`
- `docs/learning_dashboard.md`
- `PROJECT_STATUS.md`

你要先知道這個 repo 是教學範例，不是完整產品。目標是學會 Flutter app 的常見組成：語法、Widget、狀態、資料、路由、主題、儲存、測試與 CI。

如果你中途不知道下一科要讀什麼，回到 `docs/learning_dashboard.md`，用「我想學會」或「我遇到的問題」查下一個入口。

## Phase 1：Dart 基礎

閱讀：

- `docs/lessons/DART_BASICS_GUIDE.md`
- `dart_foundation/01_variables_null_safety.dart`
- `dart_foundation/02_collections.dart`
- `dart_foundation/03_async_programming.dart`
- `dart_foundation/04_oop_advanced.dart`

學習重點：

- Null safety
- `final` / `const`
- Collection 操作
- `Future` / `Stream`
- sealed class 與 pattern matching

## Phase 2：Flutter UI 與 Layout

閱讀：

- `docs/lessons/FLUTTER_UI_GUIDE.md`
- `docs/lessons/UI_COMPONENT_LIBRARY.md`
- `lib/01_basic_widgets.dart`
- `lib/03_layout_principles.dart`
- `lib/04_responsive_layout.dart`
- `lib/views/ui_kit_view.dart`

學習重點：

- Widget composition
- Constraint-based layout
- Material 3 元件
- 響應式 layout
- UI 元件如何拆分

## Phase 3：App Shell

閱讀：

- `lib/main.dart`
- `lib/core/router.dart`
- `lib/core/theme.dart`
- `lib/views/home_page.dart`
- `docs/lessons/ROUTING_NAVIGATION_GUIDE.md`
- `docs/lessons/THEME_AND_STYLING_GUIDE.md`

學習重點：

- `ProviderScope`
- `MaterialApp.router`
- `go_router`
- ThemeData / ColorScheme
- app shell 和 feature screen 的分工

## Phase 4：Feature-first + MVVM

閱讀：

- `docs/architecture_overview.md`
- `docs/features/posts.md`
- `lib/features/posts/`

學習重點：

- `domain/` 放 domain model
- `data/` 放 API service 與 repository
- `presentation/` 放 ViewModel 與 View
- View 不直接碰 HTTP
- Repository 是 feature data 的入口

## Phase 5：測試與品質

閱讀：

- `docs/testing_strategy.md`
- `test/unit_test.dart`
- `test/widget_test.dart`
- `test/features/posts/`
- `integration_test/app_test.dart`
- `docs/governance/official_sample_quality_checklist.md`

學習重點：

- Unit test 測 domain/data logic
- Widget test 測 UI rendering 和 user interaction
- Integration test 測完整 app 流程
- Fake repository 如何讓 UI 測試不依賴網路

## Phase 6：CI 與遠端驗證

閱讀：

- `docs/ci_and_environment.md`
- `.github/workflows/flutter.yml`

學習重點：

- 本機不能安裝 Flutter 時，如何靠 GitHub Actions 驗證
- `flutter analyze` 和 `flutter test` 在 sample 專案中的角色

## Phase 7：整理成 Blog 筆記

閱讀：

- `docs/blog_learning_journal.md`
- `docs/learning_dashboard.md`

學習重點：

- 把每一個主題整理成「問題、文件、程式入口、理解、測試、下一步」。
- 讓 Blog 文章不是單純筆記，而是可以帶讀者一起走過這個 repo。
- 每篇文章最後都要留下下一個學習主題，形成連續學習路線。
