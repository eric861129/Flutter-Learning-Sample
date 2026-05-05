# 學習路線總覽

這份文件只負責回答一件事：**從零開始學 Flutter，整體順序應該怎麼走？**

如果你要每日任務，請看 [7_day_flutter_learning_plan.md](7_day_flutter_learning_plan.md)。如果你想先知道七天後會完成什麼，請看 [project_brief.md](project_brief.md)。

## 路線圖

| 階段 | 主題 | 先讀 | 對照程式碼 | 學完後應該理解 |
| --- | --- | --- | --- | --- |
| Phase 0 | 專案地圖 | [README.md](../README.md), [project_brief.md](project_brief.md), [docs/README.md](README.md) | 專案目錄 | 這是 Flutter Learning Lab，不是產品模板 |
| Phase 1 | Dart 基礎 | [lessons/DART_BASICS_GUIDE.md](lessons/DART_BASICS_GUIDE.md) | `dart_foundation/` | null safety、async、collection、class |
| Phase 2 | Widget 心智模型 | [lessons/WIDGET_MENTAL_MODEL.md](lessons/WIDGET_MENTAL_MODEL.md) | `lib/views/home_page.dart` | Everything is a Widget、Widget tree |
| Phase 3 | UI / Layout / Form | [lessons/FLUTTER_UI_GUIDE.md](lessons/FLUTTER_UI_GUIDE.md), [lessons/FORM_VALIDATION_GUIDE.md](lessons/FORM_VALIDATION_GUIDE.md) | `lib/01_basic_widgets.dart`, `lib/features/profile_form/` | layout constraints、Material 3、validator |
| Phase 4 | App Shell | [architecture_overview.md](architecture_overview.md) | `lib/main.dart`, `lib/app.dart`, `lib/core/router.dart`, `lib/core/theme.dart` | app 如何啟動、導航、套用主題 |
| Phase 5 | Feature-first | [features/posts.md](features/posts.md), [features/settings.md](features/settings.md) | `lib/features/` | domain/data/presentation 分工 |
| Phase 6 | State / Network / Storage | [lessons/ADVANCED_STATE_NETWORK.md](lessons/ADVANCED_STATE_NETWORK.md), [lessons/LOCAL_STORAGE_GUIDE.md](lessons/LOCAL_STORAGE_GUIDE.md) | `lib/services/`, `lib/features/posts/`, `lib/features/settings/` | Repository、ViewModel、AsyncValue、SharedPreferences |
| Phase 7 | Testing / CI | [testing_strategy.md](testing_strategy.md), [ci_and_environment.md](ci_and_environment.md) | `test/`, `.github/workflows/flutter.yml` | fake repository、widget test、CI 驗證 |
| Phase 8 | 回顧、發布概念與擴充 | [lessons/NATIVE_TESTING_DEPLOYMENT.md](lessons/NATIVE_TESTING_DEPLOYMENT.md), [learning_dashboard.md](learning_dashboard.md), [adding_new_samples.md](adding_new_samples.md) | 新 sample | 能規劃下一個 feature、打包驗收項目與文件測試 |

## 推薦節奏

每個階段都用同一個方式讀：

1. 先讀概念文件，知道這個主題解決什麼問題。
2. 打開一個入口檔案，不急著讀完整 repo。
3. 從畫面往下追到 ViewModel、Repository 或 Service。
4. 看對應測試，理解這個設計怎麼被驗證。
5. 做章末「最小修改練習」。

## 什麼時候回到哪份文件

| 狀況 | 回到 |
| --- | --- |
| 不知道今天要讀什麼 | [7_day_flutter_learning_plan.md](7_day_flutter_learning_plan.md) |
| 不知道這個專案七天後會長怎樣 | [project_brief.md](project_brief.md) |
| 不知道某個主題在哪裡 | [learning_dashboard.md](learning_dashboard.md) |
| 不知道範例對應哪些檔案 | [sample_index.md](sample_index.md) |
| 不知道架構為什麼這樣分 | [architecture_overview.md](architecture_overview.md) |
| 不知道測試要補哪一層 | [testing_strategy.md](testing_strategy.md) |
| 想新增自己的 feature | [adding_new_samples.md](adding_new_samples.md) |

## 七天後的能力目標

學完這條路線後，你應該能：

- 解釋 Flutter app 從 `main()` 到 feature 畫面的基本流程。
- 分辨 Widget、ViewModel、Repository、Service 的責任。
- 看懂 feature-first 目錄結構。
- 替簡單 feature 補 repository test、ViewModel test、widget test。
- 在沒有本機 Flutter SDK 的限制下，知道如何透過 CI 驗證專案。
- 說出 build、flavor、artifact、app icon、splash 這些發布前概念的用途。
