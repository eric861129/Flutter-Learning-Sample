# 七天 Flutter Learning Lab 學習計畫

這份計畫適合每天投入約 1 小時，從零開始完成一個具備實踐價值的 Flutter 學習型專案：**Flutter Learning Lab**。

專案主題請先讀：[project_brief.md](project_brief.md)

## 使用方式

每天照這個節奏走：

1. 先讀「今日閱讀」。
2. 打開「今日要看的檔案」，只追一條主線。
3. 確認「今日要改的檔案」，不要到處亂改。
4. 完成「今日實作」。
5. 用「完成標準」檢查自己是不是真的懂。
6. 把卡住的地方記到自己的學習筆記。

如果本機可以安裝 Flutter，請每天至少跑一次：

```bash
flutter analyze
flutter test
```

如果本機不能安裝 Flutter，請改用 GitHub Actions 驗證，並把本機無法執行的限制記錄在 `PROJECT_STATUS.md`。

## 學習路線圖

| Day | 主題 | 當日目標 | 完成後你會得到 |
| --- | --- | --- | --- |
| Day 1 | 環境建立與 Dart 語法精要 | 了解 Flutter 工具鏈、Dart 基礎與專案主題 | 能讀懂 Dart 範例與 repo 入口 |
| Day 2 | Everything is a Widget | 理解 Widget tree、Layout、Material 3 | 能看懂畫面如何被 Widget 組出來 |
| Day 3 | Form 與 App Shell | 表單驗證、route、theme、app 啟動流程 | 能追出 `main.dart` 到 feature 頁面的路徑 |
| Day 4 | Posts API 列表 | Dio、Repository、ViewModel、search/filter/pagination | 能看懂實戰列表頁資料流 |
| Day 5 | Settings 與本地儲存 | SharedPreferences、ThemeMode、使用者偏好 | 能做出會記住使用者選擇的設定頁 |
| Day 6 | Testing 與 CI | repository test、ViewModel test、widget test、coverage | 能用 fake repository 測 UI 與狀態 |
| Day 7 | 打包發布概念與品質驗收 | build、flavor、artifact、官方 sample 檢查表 | 能評估專案完成度與下一步 |

## Day 1：環境建立與 Dart 語法精要

目標：先知道 Flutter 專案怎麼被建立、怎麼被驗證，並補齊 Dart 基礎語法。

今日閱讀：

- [project_brief.md](project_brief.md)
- [ci_and_environment.md](ci_and_environment.md)
- [lessons/DART_BASICS_GUIDE.md](lessons/DART_BASICS_GUIDE.md)

今日要看的檔案：

- `pubspec.yaml`
- `analysis_options.yaml`
- `lib/main.dart`
- `lib/app.dart`
- `dart_foundation/01_variables_null_safety.dart`
- `dart_foundation/02_collections.dart`
- `dart_foundation/03_async_programming.dart`
- `dart_foundation/04_oop_advanced.dart`

今日要改的檔案：

- `dart_foundation/01_variables_null_safety.dart`
- 學習筆記，記錄本機是否能執行 Flutter 指令。

今日實作：

1. 確認你屬於哪一種環境：
   - 可安裝 Flutter：執行 `flutter --version`、`flutter doctor`、`flutter pub get`。
   - 不可安裝 Flutter：確認 `.github/workflows/flutter.yml` 會負責跑 analyzer/test。
2. 用白話理解工具鏈：
   - Flutter SDK：負責提供 Flutter framework、build tool 與 `flutter` 指令。
   - Dart SDK：負責 Dart 語言、編譯與 `dart` 指令。
   - IDE：例如 VS Code 或 Android Studio，負責編輯、提示、除錯。
   - emulator：手機模擬器，讓你不用真的拿手機也能跑 app。
3. 閱讀 `pubspec.yaml`，知道 dependencies 和 dev_dependencies 的差別。
4. 讀懂第一個 app 入口：`lib/main.dart` 只負責啟動，`lib/app.dart` 負責組裝 `MaterialApp.router`、theme 與 router。
5. 在 Dart 範例中新增一個 nullable 欄位，並用 `??` 給預設值。
6. 用自己的話寫下：`final`、`const`、`Future`、`async` / `await` 各解決什麼問題。

完成標準：

- 你能說出 Flutter SDK、Dart SDK、package、CI 各自是什麼。
- 你能說出 IDE 和 emulator 在 Flutter 開發流程中扮演什麼角色。
- 你能解釋 `main.dart` 和 `app.dart` 的分工。
- 你能解釋為什麼 null safety 可以減少 runtime error。
- 你知道本機不能安裝 Flutter 時，驗證責任要交給 GitHub Actions。

常見錯誤：

- 一開始就想跑 UI，但還不知道 `pubspec.yaml` 管什麼。
- 把 `main.dart` 當成所有程式碼都要塞進去的地方，導致入口越來越難讀。
- 以為 emulator 是 Flutter 的一部分；實際上 emulator 是用來模擬 Android/iOS 裝置的工具。
- 看到 `String?`、`!`、`??` 時只背語法，沒有理解它們是在處理「值可能不存在」。

## Day 2：Everything is a Widget

目標：理解 Flutter 畫面不是傳統 HTML/CSS，而是由 Widget tree 描述 UI。

今日閱讀：

- [lessons/WIDGET_MENTAL_MODEL.md](lessons/WIDGET_MENTAL_MODEL.md)
- [lessons/FLUTTER_UI_GUIDE.md](lessons/FLUTTER_UI_GUIDE.md)
- [lessons/UI_COMPONENT_LIBRARY.md](lessons/UI_COMPONENT_LIBRARY.md)

今日要看的檔案：

- `lib/views/home_page.dart`
- `lib/01_basic_widgets.dart`
- `lib/02_state_management.dart`
- `lib/03_layout_principles.dart`
- `lib/04_responsive_layout.dart`
- `lib/views/ui_kit_view.dart`

今日要改的檔案：

- `lib/views/ui_kit_view.dart`
- 或 `lib/01_basic_widgets.dart`

今日實作：

1. 從 `lib/views/home_page.dart` 找出首頁由哪些 Widget 組成。
2. 在 UI Kit 中新增或調整一個 Material 3 元件。
3. 找一段巢狀 Widget，改寫成「父 Widget -> 子 Widget」的文字樹。

完成標準：

- 你能解釋「Everything is a Widget」不是口號，而是 Flutter 的 UI 組合方式。
- 你能把一段巢狀 Widget 改寫成簡單的 Widget tree。
- 你能分辨 `StatelessWidget` 和 `StatefulWidget`。
- 你能說明 `build()` 回傳的是目前狀態下的畫面描述。
- 你知道 `Row` / `Column` overflow 通常和 constraints 有關。

常見錯誤：

- 只看到括號很多，就覺得 Flutter 很亂。
- 把整個畫面都塞在同一個 `build()` 裡，導致後面很難閱讀與測試。
- 用固定寬高硬排畫面，導致小螢幕或字體放大時爆版。

## Day 3：Form、Router 與 Theme

目標：把單一畫面能力接到 App Shell，理解表單、路由、主題如何共同組成 app。

今日閱讀：

- [lessons/FORM_VALIDATION_GUIDE.md](lessons/FORM_VALIDATION_GUIDE.md)
- [architecture_overview.md](architecture_overview.md)
- [lessons/ROUTING_NAVIGATION_GUIDE.md](lessons/ROUTING_NAVIGATION_GUIDE.md)
- [lessons/THEME_AND_STYLING_GUIDE.md](lessons/THEME_AND_STYLING_GUIDE.md)

今日要看的檔案：

- `lib/main.dart`
- `lib/app.dart`
- `lib/core/router.dart`
- `lib/core/theme.dart`
- `lib/views/home_page.dart`
- `lib/features/profile_form/`

今日要改的檔案：

- `lib/features/profile_form/presentation/profile_form_view.dart`
- `lib/features/profile_form/presentation/profile_form_validators.dart`
- `test/features/profile_form/presentation/profile_form_validators_test.dart`
- `test/features/profile_form/presentation/profile_form_view_test.dart`

今日實作：

1. 追一次 app 啟動流程：`main.dart` -> `ProviderScope` -> `app.dart` -> router -> home page。
2. 在 Profile Form 新增一個欄位，例如手機號碼，並補 validator。
3. 替新增欄位補 validator test 或 widget test。
4. 確認首頁有 route 可以進到 Profile Form。

完成標準：

- 你能說出 `ProviderScope` 為什麼放在 app 根部。
- 你能說出 `main.dart`、`app.dart`、`router.dart` 的分工。
- 你能說出 `Form`、`TextFormField`、`validator` 的分工。
- 你知道 Theme 不應散落在每個 Widget 裡。

常見錯誤：

- 用 `TextField` 做所有表單，最後每個欄位錯誤都要自己手動管理。
- 把 route、theme、首頁 UI 都塞進 `main.dart`。
- 新增表單欄位後忘記同步 validator test 或 widget test。

## Day 4：Posts API、Search、Filter、Pagination

目標：理解實戰列表頁的資料流與狀態管理。

今日閱讀：

- [features/posts.md](features/posts.md)
- [lessons/ADVANCED_STATE_NETWORK.md](lessons/ADVANCED_STATE_NETWORK.md)

今日要看的檔案：

- `lib/services/api_client.dart`
- `lib/features/posts/domain/post.dart`
- `lib/features/posts/domain/post_query.dart`
- `lib/features/posts/data/post_api_service.dart`
- `lib/features/posts/data/post_repository.dart`
- `lib/features/posts/presentation/post_list_state.dart`
- `lib/features/posts/presentation/post_list_view_model.dart`
- `lib/features/posts/presentation/post_list_view.dart`

今日要改的檔案：

- `lib/features/posts/domain/post_query.dart`
- `test/features/posts/data/post_repository_test.dart`
- `test/features/posts/presentation/post_list_view_model_test.dart`
- `test/features/posts/presentation/post_list_view_test.dart`

今日實作：

1. 從 `PostListView` 往下追到 `ApiClient`，畫出資料流。
2. 修改 `PostQuery` 的 `pageSize`，觀察「載入更多」邏輯會怎麼變。
3. 在 widget test 補一個搜尋沒有結果的情境。

完成標準：

- 你能解釋 View 為什麼不直接呼叫 Dio。
- 你能說出 Repository、ViewModel、View 各自負責什麼。
- 你能說出 `AsyncValue<PostListState>` 和 `PostListState` 分別管理哪一種狀態。
- 你能解釋 debounce、filter、pagination 解決哪些真實列表問題。
- 你能說明本專案為什麼先用本地 filter / pagination 包裝 JSONPlaceholder 資料。

常見錯誤：

- 在 Widget 裡直接寫 API 呼叫。
- 載入更多時把整個畫面切回 full-screen loading，造成使用者體驗中斷。
- 只補 widget test，卻忘記 repository / ViewModel 的列表邏輯也需要測試。

## Day 5：Settings、本地儲存與使用者偏好

目標：理解 app 如何記住使用者選擇，例如深色模式。

今日閱讀：

- [features/settings.md](features/settings.md)
- [lessons/LOCAL_STORAGE_GUIDE.md](lessons/LOCAL_STORAGE_GUIDE.md)

今日要看的檔案：

- `lib/features/settings/`
- `lib/services/storage_service.dart`
- `lib/app.dart`
- `lib/main.dart`

今日要改的檔案：

- `lib/features/settings/domain/user_preferences.dart`
- `lib/features/settings/data/settings_repository.dart`
- `lib/features/settings/presentation/settings_view_model.dart`
- `lib/features/settings/presentation/settings_view.dart`
- `test/features/settings/data/settings_repository_test.dart`
- `test/features/settings/presentation/settings_view_model_test.dart`
- `test/features/settings/presentation/settings_view_test.dart`

今日實作：

1. 追一次 ThemeMode 如何從 Settings feature 回到 `lib/app.dart` 的 `MaterialApp.router`。
2. 新增一個 boolean 偏好，例如「顯示教學提示」。
3. 替新增偏好補 repository test、ViewModel test 或 widget test。

完成標準：

- 你能說出 SharedPreferences 適合存什麼、不適合存什麼。
- 你知道 storage key 不應散落在 UI 裡。
- 你能解釋 SettingsRepository 為什麼存在。
- 你能說明 `UserPreferences` 如何從 repository 進到 `MyApp`。

常見錯誤：

- 把使用者偏好直接存在 Widget state，導致 app 重開就消失。
- 在畫面裡到處手寫 storage key。
- 新增偏好後只改資料層，忘記同步 ViewModel、UI 與測試。

## Day 6：Testing、Fake Repository 與 CI

目標：學會用測試保護 feature，並理解 CI 如何補足本機環境限制。

今日閱讀：

- [testing_strategy.md](testing_strategy.md)
- [ci_and_environment.md](ci_and_environment.md)
- [governance/official_sample_quality_checklist.md](governance/official_sample_quality_checklist.md)

今日要看的檔案：

- `test/features/posts/`
- `test/features/profile_form/`
- `test/features/settings/`
- `.github/workflows/flutter.yml`

今日要改的檔案：

- `test/features/posts/presentation/post_list_view_model_test.dart`
- `test/features/posts/presentation/post_list_view_test.dart`
- 或 `test/features/settings/presentation/settings_view_model_test.dart`
- 或 `test/features/settings/presentation/settings_view_test.dart`

今日實作：

1. 選一個 feature，找出 repository test、ViewModel test、widget test。
2. 補一個 error state 或 empty state 的 widget test。
3. 確認 CI workflow 會跑 `flutter analyze` 與 `flutter test --coverage`。

完成標準：

- 你能說出 repository test、ViewModel test、widget test 各測什麼。
- 你知道 fake repository 是為了讓測試穩定，不依賴真實網路。
- 你能說出 Riverpod provider override 如何把真實 repository 換成 fake repository。
- 你能解釋 coverage artifact 的用途。
- 你知道本機不能執行 Flutter 時，要改看 GitHub Actions 的 analyzer/test 結果。

常見錯誤：

- 只測 happy path，不測 loading、error、empty。
- Widget test 還去打真實 API，導致測試慢又不穩。
- 測試只檢查畫面文字，卻沒有驗證使用者互動後 state 是否改變。

## Day 7：打包發布概念、品質驗收與下一步

目標：理解從學習專案到可交付 app 之間還缺哪些工程能力。

今日閱讀：

- [lessons/NATIVE_TESTING_DEPLOYMENT.md](lessons/NATIVE_TESTING_DEPLOYMENT.md)
- [common_flutter_pitfalls.md](common_flutter_pitfalls.md)
- [governance/official_sample_quality_checklist.md](governance/official_sample_quality_checklist.md)

今日要看的檔案：

- `.github/workflows/flutter.yml`
- `docs/ci_and_environment.md`
- `docs/lessons/NATIVE_TESTING_DEPLOYMENT.md`
- `PROJECT_STATUS.md`
- `docs/sample_index.md`
- `docs/architecture_overview.md`

今日要改的檔案：

- `PROJECT_STATUS.md`
- `docs/ci_and_environment.md`
- `docs/lessons/NATIVE_TESTING_DEPLOYMENT.md`
- `docs/sample_index.md`
- `docs/governance/official_sample_quality_checklist.md`
- `assets/README.md`

今日實作：

1. 用官方 sample 檢查表 review 這個 repo。
2. 列出目前還需要 Flutter SDK 或 CI 驗證的項目。
3. 整理 dev / staging / prod 的 build command 概念表。
4. 在 `assets/README.md` 規劃 app icon 和 splash assets 的命名方式。
5. 選出下一輪要補的主題：accessibility / localization、deployment environment、或 golden test。

完成標準：

- 你知道 `flutter build`、flavor、app icon、splash、artifact 是什麼概念。
- 你能說出學習專案和可上架專案的差距。
- 你能說明 GitHub Actions artifact 可以保存哪些 build 或 coverage 產物。
- 你能規劃下一個 feature，並知道要同步補哪些文件與測試。

常見錯誤：

- 以為能 `flutter run` 就等於專案品質足夠。
- 忽略 accessibility、localization、環境設定與發布流程。
- 只記 build command，卻沒有區分 dev / staging / prod 的環境概念。

## 七天後的下一步

建議依序補：

1. Accessibility / localization。
2. Deployment / environment 實例。
3. Golden test 或 snapshot-style UI 深化。
4. 自己新增一個 feature sample，並照 [adding_new_samples.md](adding_new_samples.md) 補齊文件與測試。
