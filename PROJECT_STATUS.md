# 專案完整度狀態

最後更新：2026-05-05

## 評估摘要

這個 repo 目前定位為 Flutter 百科教學範例，不是完整商業產品模板。經過本次整理後，專案已從草稿狀態提升到「結構可讀、文件和實作較一致、可交給有 Flutter 的環境驗證」。

## 已完成

- 補齊 `pubspec.yaml` 中實作實際需要的套件。
- 新增 `analysis_options.yaml` 並啟用 `flutter_lints`。
- 修正 `lib/main.dart` 的殘留語法錯誤。
- 將 app 改為 `MaterialApp.router` + `go_router`。
- 將首頁拆成 `lib/views/home_page.dart`。
- 套用 `AppTheme.lightTheme` / `AppTheme.darkTheme`。
- 將 `StorageService` 改成 `SharedPreferencesAsync` 實作。
- 將 `ApiClient` 改成可注入 token 與 Dio 的寫法，移除硬編碼假 token。
- 將 posts 範例整理為 `lib/features/posts/` feature-first 架構，對齊 Flutter 官方架構指南的 Views、ViewModels、Repositories、Services 分層。
- 新增 Profile Form feature，示範 `Form`、`TextFormField`、validator、submit loading state 與 error display。
- 新增 Settings feature，示範 SharedPreferences、ThemeMode、使用者偏好設定與 app shell state 串接。
- 新增 integration test 範例。
- 新增 GitHub Actions workflow。
- 補上 posts repository、view model、widget fake repository 測試。
- 補上 settings repository、view model、widget fake repository 測試。
- 補上 profile form validator、view model、widget fake repository 測試。
- 補上 posts/settings widget snapshot-style UI 結構檢查。
- GitHub Actions 改為執行 `flutter test --coverage`，並上傳 coverage artifact。
- posts 測試集中在 `test/features/posts/`，和 feature 目錄對齊。
- 新增 `docs/` 知識庫入口、學習路線、範例索引、架構總覽、測試策略、CI 說明、疑難排解與新增範例規範。
- 新增 `docs/learning_dashboard.md` 查詢式學習儀表板，讓學習者能快速找到「想學什麼、該看哪裡、下一步去哪」。
- 新增七天學習計畫與查詢式學習儀表板，支援從基礎到進階逐步回顧。
- 新增 `docs/7_day_flutter_learning_plan.md`，規劃七天每日一小時的 Flutter 學習入口。
- 新增 `docs/common_flutter_pitfalls.md`，整理學習過程常見難題與雷點。
- 新增 `docs/lessons/WIDGET_MENTAL_MODEL.md`，說明 Everything is a Widget、Widget tree、StatelessWidget 與 StatefulWidget。
- 補齊每篇 lesson / feature walkthrough 的「學完你應該能回答」、「最小修改練習」、「進階挑戰」。
- 將根目錄教學型 Markdown 集中移到 `docs/lessons/`。
- 將官方等級範例檢查表移到 `docs/governance/`。
- 將架構摘要併入 `docs/architecture_overview.md`，讓根目錄只保留入口與狀態文件。
- 補強 Dart/Flutter 程式碼與測試檔的繁體中文教學註解，讓初學者能理解每個檔案在架構中的角色。
- 更新 README 與架構文件，降低文件與程式碼不一致的風險。

## 尚待有 Flutter 的環境驗證

請在可安裝 Flutter 的環境執行：

```bash
flutter pub get
flutter analyze
flutter test --coverage
flutter run
```

## 下一輪建議

- 等 CI 第一次跑完後，依 analyzer/test 結果修正剩餘問題。
- 補 `assets/` 與 app icon/splash 設定範例。
