# 七天 Flutter 學習計畫

這份計畫適合每天投入約 1 小時，用本專案從 Flutter 基礎一路走到中進階架構。每一天都包含閱讀、看程式、做最小練習與輸出筆記。

## 使用方式

每天照這個節奏走：

1. 讀當天指定文件。
2. 打開對應程式碼，只追一條主線。
3. 回答章末「學完你應該能回答」。
4. 做一題「最小修改練習」。
5. 用 [blog_learning_journal.md](blog_learning_journal.md) 記錄今天學到什麼。

## Day 1：Dart 基礎與 Null Safety

目標：先理解 Flutter 背後的語言基礎。

閱讀：

- [lessons/DART_BASICS_GUIDE.md](lessons/DART_BASICS_GUIDE.md)

對照程式碼：

- `dart_foundation/01_variables_null_safety.dart`
- `dart_foundation/02_collections.dart`
- `dart_foundation/03_async_programming.dart`
- `dart_foundation/04_oop_advanced.dart`

今天要能回答：

- `final` 和 `const` 差在哪裡？
- nullable type 為什麼能降低 runtime error？
- `Future` 和 `async` / `await` 解決什麼問題？

最小練習：

- 在 Dart 範例中新增一個 nullable 欄位，並用 `??` 提供預設值。

常見雷點：

- 還沒理解 null safety 就開始寫 Flutter UI，後面會很容易被 `null`、`!`、`?` 卡住。

## Day 2：Widget、Layout 與 UI Kit

目標：理解 Flutter UI 的組成方式與 layout 心智模型。

閱讀：

- [lessons/FLUTTER_UI_GUIDE.md](lessons/FLUTTER_UI_GUIDE.md)
- [lessons/UI_COMPONENT_LIBRARY.md](lessons/UI_COMPONENT_LIBRARY.md)

對照程式碼：

- `lib/01_basic_widgets.dart`
- `lib/03_layout_principles.dart`
- `lib/04_responsive_layout.dart`
- `lib/views/ui_kit_view.dart`

今天要能回答：

- `StatelessWidget` 和 `StatefulWidget` 的差別是什麼？
- 為什麼 Flutter layout 不是單純用 CSS 那套邏輯？
- `Row` / `Column` overflow 時應該怎麼查？

最小練習：

- 在 UI kit 新增一個常用元件區塊，例如 dropdown、segmented button 或 form input。

常見雷點：

- 用固定寬高硬排 UI，導致小螢幕、橫向、字體放大時爆版。

## Day 3：App Shell、Router 與 Theme

目標：理解 app 從 `main.dart` 到頁面的基本組裝方式。

閱讀：

- [architecture_overview.md](architecture_overview.md)
- [lessons/ROUTING_NAVIGATION_GUIDE.md](lessons/ROUTING_NAVIGATION_GUIDE.md)
- [lessons/THEME_AND_STYLING_GUIDE.md](lessons/THEME_AND_STYLING_GUIDE.md)

對照程式碼：

- `lib/main.dart`
- `lib/core/router.dart`
- `lib/core/theme.dart`
- `lib/views/home_page.dart`

今天要能回答：

- `ProviderScope` 放在 app 根部的原因是什麼？
- `MaterialApp.router` 和 `go_router` 如何合作？
- Theme 為什麼要集中在 `core/theme.dart`？

最小練習：

- 新增一個簡單 route，並從首頁加一個入口連過去。

常見雷點：

- 把所有頁面、theme、router 都塞進 `main.dart`，專案一長就很難維護。

## Day 4：Posts Feature、API 與 Riverpod State

目標：理解 feature-first、Repository、ViewModel、AsyncValue 的資料流。

閱讀：

- [features/posts.md](features/posts.md)
- [lessons/ADVANCED_STATE_NETWORK.md](lessons/ADVANCED_STATE_NETWORK.md)

對照程式碼：

- `lib/features/posts/`
- `lib/services/api_client.dart`

今天要能回答：

- View 為什麼不直接呼叫 Dio？
- Repository 在資料流中負責什麼？
- `AsyncValue.when` 如何對應 loading / data / error？

最小練習：

- 替 posts 新增空列表 UI，並補一個 widget test。

常見雷點：

- 在 Widget 裡直接寫 API 呼叫，會讓測試、錯誤處理、重構都變困難。

## Day 5：Settings Feature、本地儲存與偏好設定

目標：理解 SharedPreferences、ThemeMode 與使用者偏好設定。

閱讀：

- [features/settings.md](features/settings.md)
- [lessons/LOCAL_STORAGE_GUIDE.md](lessons/LOCAL_STORAGE_GUIDE.md)

對照程式碼：

- `lib/features/settings/`
- `lib/services/storage_service.dart`
- `lib/main.dart`

今天要能回答：

- 為什麼 theme mode 適合存在本地？
- `SettingsRepository` 如何隔離 SharedPreferences 細節？
- `MyApp` 如何套用使用者選擇的 theme mode？

最小練習：

- 新增一個 boolean 偏好，例如「顯示教學提示」，並補 repository test。

常見雷點：

- 把儲存 key 散落在 UI 裡，之後改名或重構會很容易漏。

## Day 6：Testing、Fake Repository 與 CI

目標：理解 unit / widget / integration test 的分工，以及 CI 如何保護專案。

閱讀：

- [testing_strategy.md](testing_strategy.md)
- [ci_and_environment.md](ci_and_environment.md)
- [governance/official_sample_quality_checklist.md](governance/official_sample_quality_checklist.md)

對照程式碼：

- `test/features/posts/`
- `test/features/settings/`
- `.github/workflows/flutter.yml`

今天要能回答：

- Repository test、ViewModel test、widget test 各測什麼？
- fake repository 為什麼能讓 UI test 穩定？
- coverage artifact 的用途是什麼？

最小練習：

- 替一個現有 widget test 加上 snapshot-style 結構檢查。

常見雷點：

- 只測 happy path，不測 loading / error / empty state。

## Day 7：整合複習、Blog 輸出與下一步

目標：把前六天學到的東西串成自己的 Flutter 學習地圖。

閱讀：

- [learning_dashboard.md](learning_dashboard.md)
- [blog_learning_journal.md](blog_learning_journal.md)
- [common_flutter_pitfalls.md](common_flutter_pitfalls.md)

對照程式碼：

- `lib/`
- `docs/features/`
- `test/`

今天要能回答：

- 一個 Flutter app 從入口到 feature 通常怎麼分層？
- 什麼情境要抽 Repository / ViewModel？
- 你現在最想補的下一個 feature 是什麼？

最小練習：

- 用 Blog 模板寫一篇「我用這個 repo 學 Flutter 的第一週」。

常見雷點：

- 只看文件不動手。Flutter 的學習需要透過小修改建立肌肉記憶。

## 七天後的下一步

建議依序補：

1. Form / validator 範例。
2. Posts search / filter / pagination。
3. Accessibility / localization。
4. Deployment / environment。
