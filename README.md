# Flutter 百科教學範例專案

這是一個以「官方 Flutter samples 品質」為目標的 Flutter 學習型範例專案。它不是單一 demo，也不是完整商業產品，而是一個可以照順序閱讀、對照程式碼、理解架構、練習測試的 Flutter 知識庫。

你可以把這個 repo 當成：

- Flutter / Dart 入門教材。
- 現代 Flutter app 架構範例。
- feature-first + MVVM + Repository 的實作參考。
- Riverpod、Dio、go_router、Material 3、SharedPreferences 的整合範例。
- 沒有本機 Flutter 環境時，透過 GitHub Actions 驗證的學習專案。

> 目前作者這台電腦無法安裝 Flutter，因此本專案採用「本機可閱讀維護、CI 負責 Flutter 驗證」的工作流。

## 快速開始

如果你第一次進來，建議照這個順序：

1. 看 [docs/7_day_flutter_learning_plan.md](./docs/7_day_flutter_learning_plan.md)，照七天每日一小時學習。
2. 讀 [docs/project_brief.md](./docs/project_brief.md)，先知道七天後會完成什麼。
3. 查 [docs/learning_dashboard.md](./docs/learning_dashboard.md)，快速找到「想學什麼、該看哪裡、下一步去哪」。
4. 用 [docs/sample_index.md](./docs/sample_index.md) 找範例、程式碼與測試。
5. 用 [docs/common_flutter_pitfalls.md](./docs/common_flutter_pitfalls.md) 對照常見雷點。

完整文件中心：[docs/README.md](./docs/README.md)

## 30 秒看懂結構

```text
Flutter-Learning-Sample/
  README.md                 # GitHub 首頁與快速學習入口
  PROJECT_STATUS.md          # 目前完成度、限制、下一步
  docs/                      # 完整知識庫
    README.md                # 文件總入口
    project_brief.md         # 專案主題與七天成果
    7_day_flutter_learning_plan.md
    learning_dashboard.md
    learning_path.md
    sample_index.md
    lessons/                 # 課程教材
    features/                # feature walkthrough
    governance/              # 維護規範
  dart_foundation/           # 純 Dart 語法範例
  lib/
    core/                    # router、theme
    services/                # 共用 API / storage service
    views/                   # 首頁與 UI kit
    features/
      posts/
      profile_form/
      settings/
  test/                      # unit / widget tests
  integration_test/          # integration smoke test
```

## 核心學習範例

| 主題 | 文件 | 程式碼 |
| --- | --- | --- |
| Dart 基礎 | [Dart 基礎指南](./docs/lessons/DART_BASICS_GUIDE.md) | `dart_foundation/` |
| Widget 心智模型 | [Everything is a Widget](./docs/lessons/WIDGET_MENTAL_MODEL.md) | `lib/views/home_page.dart` |
| Flutter UI / Layout | [UI 與元件指南](./docs/lessons/FLUTTER_UI_GUIDE.md) | `lib/01_basic_widgets.dart` |
| Form | [表單與驗證指南](./docs/lessons/FORM_VALIDATION_GUIDE.md) | `lib/features/profile_form/` |
| App Shell | [架構總覽](./docs/architecture_overview.md) | `lib/main.dart`, `lib/app.dart`, `lib/core/router.dart` |
| Posts | [posts walkthrough](./docs/features/posts.md) | `lib/features/posts/` |
| Settings | [settings walkthrough](./docs/features/settings.md) | `lib/features/settings/` |
| Testing / CI | [測試策略](./docs/testing_strategy.md) | `test/`, `.github/workflows/flutter.yml` |

完整索引：[docs/sample_index.md](./docs/sample_index.md)

## 專案架構

本專案採用 feature-first 分層。每個完整 feature 盡量維持同一種可學習結構：

```text
lib/features/<feature>/
  domain/        # 純資料模型與規則
  data/          # repository、API 或本地儲存
  presentation/  # ViewModel、View、validator
```

典型資料流：

```text
View -> ViewModel -> Repository -> Service / API / Storage
```

詳細說明：[docs/architecture_overview.md](./docs/architecture_overview.md)

## 如何執行與驗證

在有 Flutter SDK 的環境：

```bash
flutter pub get
flutter analyze
flutter test --coverage
flutter run
```

純 Dart 範例：

```bash
dart run dart_foundation/01_variables_null_safety.dart
```

本機無法安裝 Flutter 時：

- 直接閱讀 `docs/` 與 `lib/`。
- 推到 GitHub 後由 `.github/workflows/flutter.yml` 執行 `flutter analyze` 與 `flutter test --coverage`。
- 詳見 [docs/ci_and_environment.md](./docs/ci_and_environment.md)。

## 目前狀態

目前已具備 app shell、posts/settings/profile form 三個 feature-first 範例、posts search/filter/pagination、測試範例、CI 設定與繁體中文教學文件。

限制：

- 本機目前沒有 Flutter SDK，因此本機無法執行 `flutter analyze` / `flutter test`。
- 需要依 GitHub Actions 或有 Flutter 的環境確認最終 analyzer/test 結果。

詳細狀態：[PROJECT_STATUS.md](./PROJECT_STATUS.md)

## 新增範例規範

新增 feature 時請同步補齊：

- `lib/features/<feature_name>/domain|data|presentation`
- `docs/features/<feature_name>.md`
- unit / ViewModel / widget test
- [docs/sample_index.md](./docs/sample_index.md)
- 重要 class、provider、service、repository、view model 的繁體中文教學註解

完整規範：[docs/adding_new_samples.md](./docs/adding_new_samples.md)
