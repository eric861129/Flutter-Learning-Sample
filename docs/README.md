# Flutter Learning Knowledge Base

這裡是本專案的完整文件中心。根目錄的 `README.md` 負責讓 GitHub 訪客快速理解專案；`docs/` 則負責保存可以長期維護的學習路線、範例索引、架構說明、測試策略與治理規範。

## 文件地圖

| 分類 | 文件 | 說明 |
| --- | --- | --- |
| 起點 | [7_day_flutter_learning_plan.md](7_day_flutter_learning_plan.md) | 七天每日一小時 Flutter 學習計畫 |
| 起點 | [learning_dashboard.md](learning_dashboard.md) | 查詢式學習儀表板：想學什麼、看哪裡、下一步去哪 |
| 起點 | [learning_path.md](learning_path.md) | 建議學習順序，適合第一次閱讀 |
| 起點 | [sample_index.md](sample_index.md) | 所有範例入口與學習目標 |
| 教材 | [lessons/README.md](lessons/README.md) | 課程教材總入口 |
| 教材 | [lessons/WIDGET_MENTAL_MODEL.md](lessons/WIDGET_MENTAL_MODEL.md) | Everything is a Widget 心智模型 |
| 架構 | [architecture_overview.md](architecture_overview.md) | 目錄結構、資料流、feature-first 原則 |
| Feature | [features/profile_form.md](features/profile_form.md) | profile form feature walkthrough |
| Feature | [features/posts.md](features/posts.md) | posts feature walkthrough |
| Feature | [features/settings.md](features/settings.md) | settings feature walkthrough |
| 測試 | [testing_strategy.md](testing_strategy.md) | unit、widget、integration test 策略 |
| 環境 | [ci_and_environment.md](ci_and_environment.md) | 本機無 Flutter 時的 CI 驗證方式 |
| 擴充 | [adding_new_samples.md](adding_new_samples.md) | 新增範例規範 |
| 分享 | [blog_learning_journal.md](blog_learning_journal.md) | Blog 學習紀錄模板與文章順序 |
| 治理 | [governance/official_sample_quality_checklist.md](governance/official_sample_quality_checklist.md) | 官方等級 sample 檢查表 |
| 參考 | [glossary.md](glossary.md) | 術語表 |
| 參考 | [common_flutter_pitfalls.md](common_flutter_pitfalls.md) | 常見難題與雷點 |
| 參考 | [troubleshooting.md](troubleshooting.md) | 疑難排解 |

## 三種閱讀方式

### 1. 我是初學者

照順序讀：

1. [learning_path.md](learning_path.md)
2. [7_day_flutter_learning_plan.md](7_day_flutter_learning_plan.md)
3. [learning_dashboard.md](learning_dashboard.md)
4. [lessons/DART_BASICS_GUIDE.md](lessons/DART_BASICS_GUIDE.md)
5. [lessons/WIDGET_MENTAL_MODEL.md](lessons/WIDGET_MENTAL_MODEL.md)
6. [lessons/FLUTTER_UI_GUIDE.md](lessons/FLUTTER_UI_GUIDE.md)
7. [architecture_overview.md](architecture_overview.md)
8. [features/posts.md](features/posts.md)
9. [testing_strategy.md](testing_strategy.md)

### 2. 我想快速找範例

先看：

1. [sample_index.md](sample_index.md)
2. [learning_dashboard.md](learning_dashboard.md)
3. 對應的 `lib/` 程式碼
4. 對應的 `test/` 測試

### 3. 我要寫 Blog 分享學習過程

先看：

1. [learning_dashboard.md](learning_dashboard.md)
2. [blog_learning_journal.md](blog_learning_journal.md)
3. 對應主題的 lesson、feature walkthrough 與測試

### 4. 我要維護或擴充這個 repo

先看：

1. [architecture_overview.md](architecture_overview.md)
2. [adding_new_samples.md](adding_new_samples.md)
3. [governance/official_sample_quality_checklist.md](governance/official_sample_quality_checklist.md)
4. [ci_and_environment.md](ci_and_environment.md)

## 文件維護原則

- 文件描述的檔案路徑必須存在。
- 文件中的套件版本必須和 `pubspec.yaml` 同步。
- 每個完整 feature 都要說明學習目標、入口檔案、資料流與測試位置。
- README 只放地圖與入口，不放過長教學正文。
