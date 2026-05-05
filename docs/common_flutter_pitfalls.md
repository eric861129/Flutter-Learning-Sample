# Flutter 常見難題與雷點

這份文件整理初學 Flutter 時最常遇到的卡點。遇到問題時先回到這裡，再連回對應 lesson 或 feature。

## Dart 與 Null Safety

常見雷點：

- 太早使用 `!` 強制解 null。
- 不理解 nullable / non-nullable 的差別。
- 把 async function 當同步程式讀。

建議：

- 先讀 [lessons/DART_BASICS_GUIDE.md](lessons/DART_BASICS_GUIDE.md)。
- 看到 `String?` 時先問：沒有值時 UI 要顯示什麼？
- 看到 `Future<T>` 時先問：loading、success、error 分別怎麼處理？

## Widget 與 Layout

常見雷點：

- 看到很多巢狀括號就迷路，沒有先畫成 Widget tree。
- `Row` 裡放太長文字導致 overflow。
- 用固定高度硬排所有元件。
- 不知道 `Expanded`、`Flexible`、`SingleChildScrollView` 何時使用。

建議：

- 先讀 [lessons/WIDGET_MENTAL_MODEL.md](lessons/WIDGET_MENTAL_MODEL.md)。
- 先讀 [lessons/FLUTTER_UI_GUIDE.md](lessons/FLUTTER_UI_GUIDE.md)。
- 版面爆掉時先找 constraints，不要急著亂包 widget。
- 避免用固定高度處理動態文字。

## State Management

常見雷點：

- 把所有狀態都放在 Widget 裡。
- UI 直接呼叫 API。
- 沒有明確處理 loading / error。

建議：

- 先讀 [features/posts.md](features/posts.md)。
- View 只負責呈現與轉交事件。
- ViewModel 管 UI state，Repository 管資料來源。

## Form 與 Validation

常見雷點：

- 用 `TextField` 做完整表單，最後所有驗證都塞在 submit button 裡。
- validator、submit loading、server error 混在同一段 Widget code。
- 送出失敗只印 console，使用者看不到錯誤。

建議：

- 先讀 [features/profile_form.md](features/profile_form.md)。
- 欄位錯誤交給 validator。
- submit loading / success / error 交給 ViewModel state。
- server 或 repository 錯誤要顯示在畫面上的 error display。

## Router

常見雷點：

- 每個頁面自己手寫 `Navigator.push`，路由越來越分散。
- route path 改了但首頁入口沒有同步。
- detail page 不知道參數從哪裡來。

建議：

- 先讀 [lessons/ROUTING_NAVIGATION_GUIDE.md](lessons/ROUTING_NAVIGATION_GUIDE.md)。
- 路由集中在 `lib/core/router.dart`。
- 每新增 route，都同步更新首頁入口與測試。

## Theme 與 UI 一致性

常見雷點：

- 到處寫死 `Colors.blue`。
- 沒有考慮深色模式。
- 字體放大後版面爆掉。

建議：

- 先讀 [lessons/THEME_AND_STYLING_GUIDE.md](lessons/THEME_AND_STYLING_GUIDE.md)。
- 顏色優先從 `Theme.of(context).colorScheme` 取得。
- 字體優先從 `textTheme` 取得。

## Local Storage

常見雷點：

- 把 token 存進一般 SharedPreferences。
- 儲存 key 散落在 UI。
- 沒有處理資料不存在時的預設值。

建議：

- 先讀 [features/settings.md](features/settings.md)。
- key 由 repository 管理，不放在 View。
- 非敏感偏好用 SharedPreferences，敏感資料改用 secure storage。

## Testing

常見雷點：

- 只測正常成功流程。
- Widget test 打真 API。
- provider 沒有 override，導致測試不穩定。

建議：

- 先讀 [testing_strategy.md](testing_strategy.md)。
- 每個 feature 至少補 repository test、ViewModel test、widget test。
- Widget test 用 fake repository。

## CI 與本機環境

常見雷點：

- 本機沒有 Flutter SDK，就以為不能維護專案。
- 文件改了但沒有檢查連結。
- CI 失敗後沒有回頭更新專案狀態。

建議：

- 先讀 [ci_and_environment.md](ci_and_environment.md)。
- 本機先用 `rg`、`git diff --check`、Markdown 連結檢查。
- Flutter analyze / test 交給 GitHub Actions 或有 SDK 的環境。
