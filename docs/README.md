# Flutter Learning Knowledge Base

這個資料夾是專案的知識庫入口。根目錄的 README 負責快速導覽；這裡負責放可長期維護的學習路線、架構說明、測試策略與範例規範。

## 建議閱讀順序

1. [學習路線](learning_path.md)
2. [範例索引](sample_index.md)
3. [課程教材](lessons/README.md)
4. [架構總覽](architecture_overview.md)
5. [Posts Feature Walkthrough](features/posts.md)
6. [測試策略](testing_strategy.md)
7. [CI 與無 Flutter 本機環境工作流](ci_and_environment.md)
8. [新增範例規範](adding_new_samples.md)
9. [官方等級範例檢查表](governance/official_sample_quality_checklist.md)
10. [術語表](glossary.md)
11. [疑難排解](troubleshooting.md)

## 文件維護原則

- 文件描述的檔案路徑必須存在。
- 文件中的套件版本必須和 `pubspec.yaml` 同步。
- 每個範例都要說明學習目標、入口檔案、資料流與測試位置。
- README 只放地圖，不放過長教學正文。
