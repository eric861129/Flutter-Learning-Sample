# Flutter 百科教學範例專案

這是一個以「官方 Flutter samples 品質」為目標的 Flutter 學習型範例專案。它不是單一 demo，也不是完整商業產品，而是一個可以照順序閱讀、對照程式碼、理解架構、練習測試的 Flutter 知識庫。

你可以把這個 repo 當成：

- Flutter / Dart 入門教材
- 現代 Flutter app 架構範例
- feature-first + MVVM + Repository 的實作參考
- Riverpod、Dio、go_router、Material 3、SharedPreferences 的整合範例
- 沒有本機 Flutter 環境時，透過 GitHub Actions 驗證的學習專案

> 目前作者這台電腦無法安裝 Flutter，因此本專案採用「本機可閱讀維護、CI 負責 Flutter 驗證」的工作流。

---

## 30 秒看懂這個專案

```text
Flutter-Learning-Sample/
  README.md                 # GitHub 首頁與快速學習入口
  PROJECT_STATUS.md          # 目前完成度、限制、下一步
  docs/                      # 完整知識庫
    README.md                # 文件總入口
    learning_path.md         # 從零開始的學習路線
    sample_index.md          # 所有範例索引
    architecture_overview.md # 專案架構與資料流
    lessons/                 # 課程教材
    features/posts.md        # posts feature 完整 walkthrough
    testing_strategy.md      # 測試策略
    governance/              # 維護規範
  dart_foundation/           # 純 Dart 語法範例
  lib/
    core/                    # router、theme
    services/                # 共用 API / storage service
    views/                   # 首頁與 UI kit
    features/posts/          # feature-first + MVVM 範例
  test/                      # unit / widget tests
  integration_test/          # integration smoke test
```

完整文件入口：[docs/README.md](./docs/README.md)

想快速查「我要學什麼、該看哪裡、下一步去哪」：

- [docs/7_day_flutter_learning_plan.md](./docs/7_day_flutter_learning_plan.md)
- [docs/learning_dashboard.md](./docs/learning_dashboard.md)
- [docs/common_flutter_pitfalls.md](./docs/common_flutter_pitfalls.md)

---

## 適合誰

- 你剛開始學 Flutter，想知道一個 app 專案通常怎麼組起來。
- 你已經會寫 Widget，但不熟狀態管理、API、路由、測試。
- 你想看一個小而完整的 feature-first 範例。
- 你想建立自己的 Flutter 範例知識庫或教學 repo。

不適合的情境：

- 你正在找可以直接上架的完整產品模板。
- 你想找大型 enterprise app 的完整 clean architecture 範本。
- 你需要本機立即 `flutter run`，但你的電腦沒有 Flutter SDK。

---

## 建議學習路線

如果你第一次進來，照這個順序讀：

1. **先看專案地圖**
   - [docs/README.md](./docs/README.md)
   - [docs/learning_dashboard.md](./docs/learning_dashboard.md)
   - [docs/sample_index.md](./docs/sample_index.md)
   - [PROJECT_STATUS.md](./PROJECT_STATUS.md)

2. **學 Dart 基礎**
   - [docs/lessons/DART_BASICS_GUIDE.md](./docs/lessons/DART_BASICS_GUIDE.md)
   - `dart_foundation/`

3. **學 Flutter UI 與 Layout**
   - [docs/lessons/FLUTTER_UI_GUIDE.md](./docs/lessons/FLUTTER_UI_GUIDE.md)
   - [docs/lessons/UI_COMPONENT_LIBRARY.md](./docs/lessons/UI_COMPONENT_LIBRARY.md)
   - `lib/01_basic_widgets.dart`
   - `lib/03_layout_principles.dart`
   - `lib/04_responsive_layout.dart`

4. **學 app shell：啟動、路由、主題**
   - `lib/main.dart`
   - `lib/core/router.dart`
   - `lib/core/theme.dart`
   - [docs/lessons/ROUTING_NAVIGATION_GUIDE.md](./docs/lessons/ROUTING_NAVIGATION_GUIDE.md)
   - [docs/lessons/THEME_AND_STYLING_GUIDE.md](./docs/lessons/THEME_AND_STYLING_GUIDE.md)

5. **學完整 feature：posts**
   - [docs/features/posts.md](./docs/features/posts.md)
   - `lib/features/posts/`
   - `test/features/posts/`

完整版本見：[docs/learning_path.md](./docs/learning_path.md)

---

## 核心範例

| 主題 | 文件 | 程式碼 |
| --- | --- | --- |
| Dart 基礎 | [Dart 基礎指南](./docs/lessons/DART_BASICS_GUIDE.md) | `dart_foundation/` |
| Widget 心智模型 | [Everything is a Widget](./docs/lessons/WIDGET_MENTAL_MODEL.md) | `lib/views/home_page.dart` |
| Flutter UI | [UI 與元件指南](./docs/lessons/FLUTTER_UI_GUIDE.md) | `lib/01_basic_widgets.dart` |
| UI Kit | [常用 UI 元件庫](./docs/lessons/UI_COMPONENT_LIBRARY.md) | `lib/views/ui_kit_view.dart` |
| Form | [表單與驗證指南](./docs/lessons/FORM_VALIDATION_GUIDE.md) | `lib/features/profile_form/` |
| Routing | [路由與導航](./docs/lessons/ROUTING_NAVIGATION_GUIDE.md) | `lib/core/router.dart` |
| Theme | [主題與視覺設計](./docs/lessons/THEME_AND_STYLING_GUIDE.md) | `lib/core/theme.dart` |
| Storage / Settings | [本地儲存與快取](./docs/lessons/LOCAL_STORAGE_GUIDE.md) | `lib/features/settings/` |
| State + Network | [狀態與網路](./docs/lessons/ADVANCED_STATE_NETWORK.md) | `lib/features/posts/` |
| Testing / Native / Deploy | [測試、原生與上架](./docs/lessons/NATIVE_TESTING_DEPLOYMENT.md) | `test/`, `integration_test/` |

完整索引見：[docs/sample_index.md](./docs/sample_index.md)

---

## 專案架構

本專案採用「小型教學專案可讀性」與「大型 app 可擴充性」之間的折衷架構：

```text
lib/
  core/       # App 全域設定：router、theme
  services/   # 跨 feature 共用服務：ApiClient、StorageService
  views/      # 首頁與 UI 展示頁
  features/
    posts/
      domain/        # Post domain model
      data/          # PostApiService、PostRepository
      presentation/  # PostListViewModel、PostListView
```

posts feature 的資料流：

```text
PostListView
  -> PostListViewModel
  -> PostRepository
  -> PostApiService
  -> ApiClient
  -> JSONPlaceholder API
```

詳細說明：[docs/architecture_overview.md](./docs/architecture_overview.md)

---

## 如何執行與驗證

在有 Flutter SDK 的環境：

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

純 Dart 範例：

```bash
dart run dart_foundation/01_variables_null_safety.dart
```

本機無法安裝 Flutter 時：

- 直接閱讀 `docs/` 與 `lib/`。
- 推到 GitHub 後由 `.github/workflows/flutter.yml` 執行 `flutter analyze` 與 `flutter test`。
- 詳見 [docs/ci_and_environment.md](./docs/ci_and_environment.md)。

---

## 文件架構

| 文件 | 用途 |
| --- | --- |
| [docs/README.md](./docs/README.md) | 知識庫總入口 |
| [docs/7_day_flutter_learning_plan.md](./docs/7_day_flutter_learning_plan.md) | 七天每日一小時學習計畫 |
| [docs/learning_dashboard.md](./docs/learning_dashboard.md) | 查詢式學習儀表板 |
| [docs/learning_path.md](./docs/learning_path.md) | 從零開始的學習路線 |
| [docs/sample_index.md](./docs/sample_index.md) | 範例索引 |
| [docs/architecture_overview.md](./docs/architecture_overview.md) | 架構與資料流 |
| [docs/features/profile_form.md](./docs/features/profile_form.md) | profile form feature walkthrough |
| [docs/features/posts.md](./docs/features/posts.md) | posts feature walkthrough |
| [docs/features/settings.md](./docs/features/settings.md) | settings feature walkthrough |
| [docs/testing_strategy.md](./docs/testing_strategy.md) | 測試策略 |
| [docs/common_flutter_pitfalls.md](./docs/common_flutter_pitfalls.md) | 常見難題與雷點 |
| [docs/lessons/README.md](./docs/lessons/README.md) | 課程教材入口 |
| [docs/governance/official_sample_quality_checklist.md](./docs/governance/official_sample_quality_checklist.md) | 官方等級範例檢查表 |
| [docs/troubleshooting.md](./docs/troubleshooting.md) | 疑難排解 |

---

## 目前狀態

目前已完成：

- Flutter app shell：`ProviderScope`、`MaterialApp.router`、theme、go_router
- feature-first posts 範例
- feature-first settings 範例
- Riverpod AsyncNotifier ViewModel
- Dio API client
- SharedPreferencesAsync storage service
- unit / widget / integration test 範例
- GitHub Actions Flutter CI
- 繁體中文教學註解與完整 docs 知識庫

限制：

- 本機目前沒有 Flutter SDK，因此本機無法執行 `flutter analyze` / `flutter test`。
- 需要依 GitHub Actions 或有 Flutter 的環境確認最終 analyzer/test 結果。

詳細狀態：[PROJECT_STATUS.md](./PROJECT_STATUS.md)

---

## 新增範例的規範

新增 feature 時請遵守：

- 使用 `lib/features/<feature_name>/domain|data|presentation`
- 補 `docs/features/<feature_name>.md`
- 補 unit / widget test
- 更新 [docs/sample_index.md](./docs/sample_index.md)
- 對重要 class、provider、service、repository、view model 補繁體中文教學註解

完整規範：[docs/adding_new_samples.md](./docs/adding_new_samples.md)
