# Flutter 百科教學範例專案

這是一個用來學習現代 Flutter 開發的百科型範例專案。目標是往官方 Flutter samples 的品質靠攏：每個範例都能清楚說明一個主題，程式碼保持可讀、可測、可擴充，文件與實作同步。

> 注意：這台電腦目前無法安裝 Flutter，因此本 repo 以「靜態可讀、可交給有 Flutter 的環境驗證」為優化方向。

---

## 快速導覽

| 你想做的事 | 從這裡開始 |
| --- | --- |
| 照順序學 Flutter | [docs/learning_path.md](./docs/learning_path.md) |
| 找某個範例 | [docs/sample_index.md](./docs/sample_index.md) |
| 了解專案架構 | [docs/architecture_overview.md](./docs/architecture_overview.md) |
| 看 posts 完整 feature | [docs/features/posts.md](./docs/features/posts.md) |
| 學測試策略 | [docs/testing_strategy.md](./docs/testing_strategy.md) |
| 本機不能裝 Flutter 時怎麼驗證 | [docs/ci_and_environment.md](./docs/ci_and_environment.md) |
| 新增自己的範例 | [docs/adding_new_samples.md](./docs/adding_new_samples.md) |
| 查術語 | [docs/glossary.md](./docs/glossary.md) |
| 排除常見問題 | [docs/troubleshooting.md](./docs/troubleshooting.md) |

完整知識庫入口：[docs/README.md](./docs/README.md)

---

## 專案狀態

- 已整理 `pubspec.yaml`，補齊範例實際使用的 `dio`、`flutter_riverpod`、`go_router`、`shared_preferences`。
- 已加入 `analysis_options.yaml`，使用官方 `flutter_lints` 規則。
- 已改用 `MaterialApp.router` 與 `go_router`，路由不再只是註解範例。
- 已套用全域亮色/深色主題。
- 已把首頁拆到 `lib/views/home_page.dart`，讓 `main.dart` 保持單純。
- 已將 posts 範例整理成 `lib/features/posts/`，示範 feature-first + MVVM 分層思路。
- 已將本地儲存服務改成 `SharedPreferencesAsync` 實作。
- 已加入 GitHub Actions workflow，讓無法安裝 Flutter 的電腦也能透過 CI 驗證。

詳細狀態：[PROJECT_STATUS.md](./PROJECT_STATUS.md)

---

## 學習模組

### 模組 1：語言基礎
Flutter 的基石。包含變數、空安全與物件導向的進階用法。
- 指南：[DART_BASICS_GUIDE.md](./docs/lessons/DART_BASICS_GUIDE.md)
- 範例：`dart_foundation/`

### 模組 2：畫面與佈局
理解「一切皆 Widget」的哲學與響應式佈局的核心法則。
- 指南：[FLUTTER_UI_GUIDE.md](./docs/lessons/FLUTTER_UI_GUIDE.md)
- 範例：`lib/01_basic_widgets.dart`、`lib/03_layout_principles.dart`、`lib/04_responsive_layout.dart`

### 模組 3：UI 元件庫
開發時必備的「複製貼上」神器。包含按鈕、表單、卡片與對話框。
- 指南：[UI_COMPONENT_LIBRARY.md](./docs/lessons/UI_COMPONENT_LIBRARY.md)
- 範例：`lib/views/ui_kit_view.dart`

### 模組 4：狀態與網路
使用 Riverpod 管理非同步狀態，使用 Dio 串接 JSONPlaceholder API。
- 指南：[ADVANCED_STATE_NETWORK.md](./docs/lessons/ADVANCED_STATE_NETWORK.md)
- 範例：`lib/features/posts/`、`lib/services/api_client.dart`

### 模組 5：路由與導航
使用 go_router 管理頁面路由，示範 declarative routing 的基本結構。
- 指南：[ROUTING_NAVIGATION_GUIDE.md](./docs/lessons/ROUTING_NAVIGATION_GUIDE.md)
- 範例：`lib/core/router.dart`

### 模組 6：本地儲存與主題
讓你的 APP 記住用戶設定，並實現專業的深/淺色模式自動切換。
- 指南：[LOCAL_STORAGE_GUIDE.md](./docs/lessons/LOCAL_STORAGE_GUIDE.md)、[THEME_AND_STYLING_GUIDE.md](./docs/lessons/THEME_AND_STYLING_GUIDE.md)
- 範例：`lib/core/theme.dart`、`lib/services/storage_service.dart`

### 模組 7：測試、原生與上架
突破框架限制調用原生 API、撰寫測試保護代碼，以及雙平台商店上架流程。
- 指南：[NATIVE_TESTING_DEPLOYMENT.md](./docs/lessons/NATIVE_TESTING_DEPLOYMENT.md)
- 範例：`test/`

---

## 專案架構

架構說明：

- [docs/architecture_overview.md](./docs/architecture_overview.md)
- [docs/governance/official_sample_quality_checklist.md](./docs/governance/official_sample_quality_checklist.md)

```text
lib/
  core/       # 路由與主題
  features/   # feature-first 範例，例如 posts
  services/   # API 與本地儲存
  views/      # 頁面與展示畫面
  main.dart   # app bootstrap
```

---

## 如何使用

1. 先讀 `docs/lessons/DART_BASICS_GUIDE.md` 與 `dart_foundation/`。
2. 再讀 `docs/lessons/FLUTTER_UI_GUIDE.md`，對照 `lib/01_basic_widgets.dart`。
3. 接著看 `lib/main.dart`、`lib/core/router.dart`、`lib/views/home_page.dart`，理解 app 如何組起來。
4. 最後看 `lib/features/posts/` 與 `test/features/posts/`，學習資料流與測試。

在有 Flutter 的環境中可執行：

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

CI 驗證位於 `.github/workflows/flutter.yml`，會在 GitHub 上執行 `flutter pub get`、`flutter analyze` 與 `flutter test`。更多環境說明見 [docs/ci_and_environment.md](./docs/ci_and_environment.md)。

純 Dart 範例可在有 Dart SDK 的環境執行：

```bash
dart run dart_foundation/01_variables_null_safety.dart
```

