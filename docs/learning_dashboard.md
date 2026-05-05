# 學習儀表板

這份文件是「我現在想學什麼，該從哪裡開始，下一步去哪裡」的快速查詢入口。當你不確定要讀哪份文件時，先回到這裡。

如果你想用固定節奏學習，請直接照 [7_day_flutter_learning_plan.md](7_day_flutter_learning_plan.md) 走七天；如果你遇到卡點，先查 [common_flutter_pitfalls.md](common_flutter_pitfalls.md)。

## 快速查詢

| 我想學會 | 先讀 | 對照程式碼 | 做完後下一步 |
| --- | --- | --- | --- |
| 七天後會做出什麼 | [project_brief.md](project_brief.md) | `README.md`、`lib/` | Dart 基礎語法 |
| Dart 完全零基礎 | [lessons/DART_ZERO_TO_ONE_CSHARP.md](lessons/DART_ZERO_TO_ONE_CSHARP.md) | `dart_foundation/01_variables_null_safety.dart`, `lib/features/posts/domain/post.dart` | Dart 基礎語法 |
| Dart 基礎語法 | [lessons/DART_BASICS_GUIDE.md](lessons/DART_BASICS_GUIDE.md) | `dart_foundation/` | Flutter UI |
| Widget 完全零基礎 | [lessons/WIDGET_ZERO_TO_ONE_CSHARP.md](lessons/WIDGET_ZERO_TO_ONE_CSHARP.md) | `lib/views/home_page.dart`, `lib/01_basic_widgets.dart` | Widget 心智模型 |
| Widget 心智模型 | [lessons/WIDGET_MENTAL_MODEL.md](lessons/WIDGET_MENTAL_MODEL.md) | `lib/views/home_page.dart` | Layout constraints |
| Widget 與畫面組合 | [lessons/FLUTTER_UI_GUIDE.md](lessons/FLUTTER_UI_GUIDE.md) | `lib/01_basic_widgets.dart` | Layout constraints |
| Flutter 版面規則 | [lessons/FLUTTER_UI_GUIDE.md](lessons/FLUTTER_UI_GUIDE.md) | `lib/03_layout_principles.dart` | Responsive layout |
| 響應式 UI | [lessons/FLUTTER_UI_GUIDE.md](lessons/FLUTTER_UI_GUIDE.md) | `lib/04_responsive_layout.dart` | UI component library |
| 常用 Material 3 元件 | [lessons/UI_COMPONENT_LIBRARY.md](lessons/UI_COMPONENT_LIBRARY.md) | `lib/views/ui_kit_view.dart` | App shell |
| 表單與驗證 | [lessons/FORM_VALIDATION_GUIDE.md](lessons/FORM_VALIDATION_GUIDE.md) | `lib/features/profile_form/` | App shell |
| App 啟動流程 | [architecture_overview.md](architecture_overview.md) | `lib/main.dart`, `lib/app.dart` | Router |
| 頁面導航 | [lessons/ROUTING_NAVIGATION_GUIDE.md](lessons/ROUTING_NAVIGATION_GUIDE.md) | `lib/core/router.dart` | Theme |
| 主題與視覺風格 | [lessons/THEME_AND_STYLING_GUIDE.md](lessons/THEME_AND_STYLING_GUIDE.md) | `lib/core/theme.dart` | Storage |
| 本地儲存與偏好設定 | [features/settings.md](features/settings.md) | `lib/features/settings/` | State + Network |
| API、狀態與分頁列表 | [lessons/ADVANCED_STATE_NETWORK.md](lessons/ADVANCED_STATE_NETWORK.md) | `lib/features/posts/` | Testing |
| 測試 | [testing_strategy.md](testing_strategy.md) | `test/` | CI |
| 無 Flutter 本機環境驗證 | [ci_and_environment.md](ci_and_environment.md) | `.github/workflows/flutter.yml` | 專案驗收 |
| 打包發布概念 | [lessons/NATIVE_TESTING_DEPLOYMENT.md](lessons/NATIVE_TESTING_DEPLOYMENT.md) | `.github/workflows/flutter.yml` | 專案驗收 |
| 專案完成度檢查 | [governance/official_sample_quality_checklist.md](governance/official_sample_quality_checklist.md) | `docs/` 與 `lib/` | 新增自己的 sample |
| 常見雷點排查 | [common_flutter_pitfalls.md](common_flutter_pitfalls.md) | 對應 lessons / features | 回到學習計畫 |

## 常見問題導向

| 我遇到的問題 | 建議入口 | 你要確認 |
| --- | --- | --- |
| 不知道 Flutter 專案從哪裡開始看 | [learning_path.md](learning_path.md) | 先看 Phase 0，再看 `lib/main.dart` |
| 不知道七天後會完成什麼 App | [project_brief.md](project_brief.md) | 看「七天後會完成什麼」表格 |
| 看得懂 Widget，但不知道資料怎麼進畫面 | [features/posts.md](features/posts.md) | 從 `PostListView` 往 Repository 追 |
| 不知道 Riverpod 在這個專案做什麼 | [lessons/ADVANCED_STATE_NETWORK.md](lessons/ADVANCED_STATE_NETWORK.md) | 看 ViewModel provider 和 test override |
| 不知道搜尋、篩選、分頁狀態怎麼設計 | [features/posts.md](features/posts.md) | 看 `PostListState` 和 `PostQuery` |
| 不知道表單錯誤要放哪裡 | [features/profile_form.md](features/profile_form.md) | 分清楚 validator error 和 submit error |
| 不知道測試要測哪一層 | [testing_strategy.md](testing_strategy.md) | Unit、ViewModel、Widget 各測不同責任 |
| 想新增一個自己的範例 | [adding_new_samples.md](adding_new_samples.md) | feature 文件、測試、索引都要同步 |
| 想確認是否接近官方 sample 品質 | [governance/official_sample_quality_checklist.md](governance/official_sample_quality_checklist.md) | 用 checklist 檢查可讀性、可測性、文件同步 |

## 每一科的學習節奏

每個主題都用同一個節奏學：

1. **讀概念**：先讀對應 lesson，知道這個主題解決什麼問題。
2. **看入口檔案**：只看一個最重要的程式入口，不急著看完整 repo。
3. **追資料流或 UI 流程**：從使用者看到的畫面往下追。
4. **回答檢查題**：用章末「學完你應該能回答」確認理解。
5. **做最小修改**：完成章末「最小修改練習」，讓知識變成手感。
6. **看測試**：理解這個主題如何被驗證。
7. **寫筆記**：用自己的筆記記錄「我學到什麼、我改了什麼、還卡在哪裡」。
8. **挑戰進階題**：挑一題「進階挑戰」作為下一輪功能素材。

## 七天回顧檢查表

| 項目 | 你要確認 | 對應文件 |
| --- | --- | --- |
| 專案入口 | 能不能從 README 找到七天學習路線 | [README.md](../README.md) |
| 專案主題 | 能不能說出 Flutter Learning Lab 要完成哪些功能 | [project_brief.md](project_brief.md) |
| 語法基礎 | 能不能說明 Dart 與 Flutter 的關係，並看懂 `class` / `fromJson` | [lessons/DART_ZERO_TO_ONE_CSHARP.md](lessons/DART_ZERO_TO_ONE_CSHARP.md), [lessons/DART_BASICS_GUIDE.md](lessons/DART_BASICS_GUIDE.md) |
| Widget 基礎 | 能不能把 `HomePage` 畫成 Widget tree，並分辨 `child` / `children` | [lessons/WIDGET_ZERO_TO_ONE_CSHARP.md](lessons/WIDGET_ZERO_TO_ONE_CSHARP.md) |
| Widget 心智模型 | 能不能用自己的話解釋 Everything is a Widget | [lessons/WIDGET_MENTAL_MODEL.md](lessons/WIDGET_MENTAL_MODEL.md) |
| UI 與表單 | 能不能分清楚 layout、元件、表單驗證責任 | [lessons/FLUTTER_UI_GUIDE.md](lessons/FLUTTER_UI_GUIDE.md) |
| App Shell | 能不能追出 main、router、theme 的關係 | [architecture_overview.md](architecture_overview.md) |
| Feature 分層 | 能不能從 View 追到 Repository | [features/posts.md](features/posts.md) |
| 本地偏好 | 能不能說明 Settings 如何影響 app theme | [features/settings.md](features/settings.md) |
| 測試策略 | 能不能分清楚 unit、ViewModel、widget test | [testing_strategy.md](testing_strategy.md) |
| CI 驗證 | 能不能說明本機無 Flutter 時如何靠 CI 補驗證 | [ci_and_environment.md](ci_and_environment.md) |

## 下一輪優化方向

這個專案若要更像真正的 Flutter 學習知識庫，後續可以逐步補：

- `docs/features/` 增加更多 feature walkthrough，例如 accessibility、localization、deployment environment。
- 每個新增 lesson / feature 都維持章末三段式檢查點。
- CI 通過後補上徽章與實際 analyzer/test 狀態。
