# Flutter Learning Knowledge Base

這裡是本專案的完整文件中心。根目錄 `README.md` 負責讓 GitHub 訪客快速理解專案；`docs/` 則保存可長期維護的學習路線、範例導讀、架構說明、測試策略與治理規範。

## 文件分層

| 層級 | 文件 | 用途 |
| --- | --- | --- |
| 起點 | [7_day_flutter_learning_plan.md](7_day_flutter_learning_plan.md) | 七天每日一小時學習計畫 |
| 起點 | [project_brief.md](project_brief.md) | Flutter Learning Lab 專案主題、範圍與七天成果 |
| 起點 | [learning_dashboard.md](learning_dashboard.md) | 查詢式入口：我想學什麼、該看哪裡 |
| 起點 | [learning_path.md](learning_path.md) | 從零到進階的路線總覽 |
| 範例 | [sample_index.md](sample_index.md) | sample catalog：範例、程式碼、測試、文件 |
| 教材 | [lessons/README.md](lessons/README.md) | 課程教材總入口 |
| 教材 | [lessons/DART_ZERO_TO_ONE_CSHARP.md](lessons/DART_ZERO_TO_ONE_CSHARP.md) | 完全零經驗或 C# 背景讀者的 Dart 語法入口 |
| 教材 | [lessons/WIDGET_ZERO_TO_ONE_CSHARP.md](lessons/WIDGET_ZERO_TO_ONE_CSHARP.md) | 完全零經驗或 C# 背景讀者的 Flutter Widget 入口 |
| 教材 | [lessons/STATE_MANAGEMENT_ZERO_TO_ONE_CSHARP.md](lessons/STATE_MANAGEMENT_ZERO_TO_ONE_CSHARP.md) | 完全零經驗或 C# 背景讀者的 Flutter 狀態管理入口 |
| Feature | [features/profile_form.md](features/profile_form.md) | profile form walkthrough |
| Feature | [features/posts.md](features/posts.md) | posts walkthrough |
| Feature | [features/settings.md](features/settings.md) | settings walkthrough |
| 架構 | [architecture_overview.md](architecture_overview.md) | 目錄結構、資料流、feature-first 原則 |
| 測試 | [testing_strategy.md](testing_strategy.md) | unit、ViewModel、widget、integration test 策略 |
| 環境 | [ci_and_environment.md](ci_and_environment.md) | 本機無 Flutter 時的 CI 驗證方式 |
| 擴充 | [adding_new_samples.md](adding_new_samples.md) | 新增範例規範 |
| 治理 | [governance/official_sample_quality_checklist.md](governance/official_sample_quality_checklist.md) | 官方等級 sample 檢查表 |
| 參考 | [common_flutter_pitfalls.md](common_flutter_pitfalls.md) | 常見難題與雷點 |
| 參考 | [troubleshooting.md](troubleshooting.md) | 疑難排解 |
| 參考 | [glossary.md](glossary.md) | 術語表 |

## 依目的閱讀

| 我想要 | 建議入口 |
| --- | --- |
| 先知道七天後會做出什麼 | [project_brief.md](project_brief.md) |
| 每天照表學 | [7_day_flutter_learning_plan.md](7_day_flutter_learning_plan.md) |
| 查某個主題該看哪裡 | [learning_dashboard.md](learning_dashboard.md) |
| 先理解完整學習地圖 | [learning_path.md](learning_path.md) |
| 找 feature 或範例位置 | [sample_index.md](sample_index.md) |
| 看每一章教材 | [lessons/README.md](lessons/README.md) |
| 確認專案是否接近官方 sample 品質 | [governance/official_sample_quality_checklist.md](governance/official_sample_quality_checklist.md) |
| 新增自己的 sample | [adding_new_samples.md](adding_new_samples.md) |

## 文件角色邊界

- `7_day_flutter_learning_plan.md`：每天要讀什麼、做到什麼。
- `project_brief.md`：定義這個學習型 App 的主題、範圍與完成樣貌。
- `learning_dashboard.md`：遇到問題或想查主題時的快速入口。
- `learning_path.md`：路線總覽，不重複每天細節。
- `sample_index.md`：只回答「有哪些範例、在哪裡、測什麼」。
- `lessons/`：概念教材與練習題。
- `features/`：實作 walkthrough，對照 `lib/features/` 與 `test/features/`。

## 文件維護原則

- 文件描述的檔案路徑必須存在。
- 文件中的套件版本必須和 `pubspec.yaml` 同步。
- 每個完整 feature 都要說明學習目標、入口檔案、資料流與測試位置。
- README 只放地圖與入口，不放過長教學正文。
- 新增 sample 時，同步更新 feature 文件、測試策略與 sample index。
