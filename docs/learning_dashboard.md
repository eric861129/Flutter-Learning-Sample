# 學習儀表板

這份文件是「我現在想學什麼，該從哪裡開始，下一步去哪裡」的快速查詢入口。當你不確定要讀哪份文件時，先回到這裡。

## 快速查詢

| 我想學會 | 先讀 | 對照程式碼 | 做完後下一步 |
| --- | --- | --- | --- |
| Dart 基礎語法 | [lessons/DART_BASICS_GUIDE.md](lessons/DART_BASICS_GUIDE.md) | `dart_foundation/` | Flutter UI |
| Widget 與畫面組合 | [lessons/FLUTTER_UI_GUIDE.md](lessons/FLUTTER_UI_GUIDE.md) | `lib/01_basic_widgets.dart` | Layout constraints |
| Flutter 版面規則 | [lessons/FLUTTER_UI_GUIDE.md](lessons/FLUTTER_UI_GUIDE.md) | `lib/03_layout_principles.dart` | Responsive layout |
| 響應式 UI | [lessons/FLUTTER_UI_GUIDE.md](lessons/FLUTTER_UI_GUIDE.md) | `lib/04_responsive_layout.dart` | UI component library |
| 常用 Material 3 元件 | [lessons/UI_COMPONENT_LIBRARY.md](lessons/UI_COMPONENT_LIBRARY.md) | `lib/views/ui_kit_view.dart` | App shell |
| App 啟動流程 | [architecture_overview.md](architecture_overview.md) | `lib/main.dart` | Router |
| 頁面導航 | [lessons/ROUTING_NAVIGATION_GUIDE.md](lessons/ROUTING_NAVIGATION_GUIDE.md) | `lib/core/router.dart` | Theme |
| 主題與視覺風格 | [lessons/THEME_AND_STYLING_GUIDE.md](lessons/THEME_AND_STYLING_GUIDE.md) | `lib/core/theme.dart` | Storage |
| 本地儲存 | [lessons/LOCAL_STORAGE_GUIDE.md](lessons/LOCAL_STORAGE_GUIDE.md) | `lib/services/storage_service.dart` | State + Network |
| API 與狀態管理 | [lessons/ADVANCED_STATE_NETWORK.md](lessons/ADVANCED_STATE_NETWORK.md) | `lib/features/posts/` | Testing |
| 測試 | [testing_strategy.md](testing_strategy.md) | `test/` | CI |
| 無 Flutter 本機環境驗證 | [ci_and_environment.md](ci_and_environment.md) | `.github/workflows/flutter.yml` | Blog 紀錄 |
| Blog 分享學習過程 | [blog_learning_journal.md](blog_learning_journal.md) | `docs/` 與 `lib/` | 新增自己的 sample |

## 常見問題導向

| 我遇到的問題 | 建議入口 | 你要確認 |
| --- | --- | --- |
| 不知道 Flutter 專案從哪裡開始看 | [learning_path.md](learning_path.md) | 先看 Phase 0，再看 `lib/main.dart` |
| 看得懂 Widget，但不知道資料怎麼進畫面 | [features/posts.md](features/posts.md) | 從 `PostListView` 往 Repository 追 |
| 不知道 Riverpod 在這個專案做什麼 | [lessons/ADVANCED_STATE_NETWORK.md](lessons/ADVANCED_STATE_NETWORK.md) | 看 ViewModel provider 和 test override |
| 不知道測試要測哪一層 | [testing_strategy.md](testing_strategy.md) | Unit、ViewModel、Widget 各測不同責任 |
| 想新增一個自己的範例 | [adding_new_samples.md](adding_new_samples.md) | feature 文件、測試、索引都要同步 |
| 想確認是否接近官方 sample 品質 | [governance/official_sample_quality_checklist.md](governance/official_sample_quality_checklist.md) | 用 checklist 檢查可讀性、可測性、文件同步 |

## 每一科的學習節奏

每個主題都用同一個節奏學：

1. **讀概念**：先讀對應 lesson，知道這個主題解決什麼問題。
2. **看入口檔案**：只看一個最重要的程式入口，不急著看完整 repo。
3. **追資料流或 UI 流程**：從使用者看到的畫面往下追。
4. **看測試**：理解這個主題如何被驗證。
5. **寫筆記**：用 [blog_learning_journal.md](blog_learning_journal.md) 的格式記錄。
6. **做延伸練習**：在不破壞原範例的前提下新增小功能。

## 建議 Blog 系列主題

| 篇數 | 主題 | 對應文件 |
| --- | --- | --- |
| 1 | 為什麼我要建立 Flutter 學習型 sample repo | [README.md](../README.md) |
| 2 | Dart 基礎與 Flutter 的關係 | [lessons/DART_BASICS_GUIDE.md](lessons/DART_BASICS_GUIDE.md) |
| 3 | Flutter Widget 與 Layout 的第一個理解關卡 | [lessons/FLUTTER_UI_GUIDE.md](lessons/FLUTTER_UI_GUIDE.md) |
| 4 | 一個 app 如何啟動：main、router、theme | [architecture_overview.md](architecture_overview.md) |
| 5 | feature-first 是什麼：用 posts 範例理解分層 | [features/posts.md](features/posts.md) |
| 6 | Riverpod、Repository、Fake Repository 怎麼一起測 | [testing_strategy.md](testing_strategy.md) |
| 7 | 沒有 Flutter 本機環境時，怎麼靠 CI 學習 | [ci_and_environment.md](ci_and_environment.md) |

## 下一輪優化方向

這個專案若要更像真正的 Flutter 學習知識庫，後續可以逐步補：

- `docs/features/` 增加更多 feature walkthrough，例如 todo、settings、auth mock。
- 每個 lesson 增加「學完後你應該能回答的問題」。
- 每個 sample 增加「最小修改練習」與「進階挑戰」。
- CI 通過後補上徽章與實際 analyzer/test 狀態。
- Blog 發布後在 README 加上「學習紀錄文章索引」。
