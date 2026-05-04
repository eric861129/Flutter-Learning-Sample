# 官方等級 Flutter 範例檢查表

本專案以 Flutter 官方 samples 的精神為目標：每個範例都要可執行、可閱讀、可測試，並且只教一個清楚主題。

## 必須符合

- 範例可以在 stable Flutter 環境執行。
- `README.md` 能說明專案目標、模組索引、執行方式與限制。
- `pubspec.yaml` 只保留實際需要的套件。
- `analysis_options.yaml` 啟用官方 lint。
- `flutter analyze` 沒有 error。
- `flutter test` 通過。
- 程式碼中的教學註解解釋「為什麼」，不重複描述「這一行做什麼」。
- 對初學者重要的 public class、provider、service、repository、view model、widget test 都要有繁體中文註解。
- 文件中的套件、API 名稱與程式碼一致。
- 每個範例只聚焦一個主題，避免把太多概念塞進同一頁。
- API token、金鑰、個人資料不可硬編碼。

## 架構標準

- `main.dart` 只做 app bootstrap。
- `core/` 放全域設定，例如 router、theme。
- `services/` 放跨 feature 共用的基礎服務，例如 API client、本地儲存。
- 功能型範例使用 `features/<feature_name>/`。
- `features/<feature_name>/domain/` 放 domain model。
- `features/<feature_name>/data/` 放 API service、repository、資料轉換。
- `features/<feature_name>/presentation/` 放 ViewModel 與 View。
- View 不直接呼叫 Dio 或本地儲存。
- ViewModel 不依賴具體 HTTP client；它依賴 repository。
- `dynamic` 不應擴散到 presentation layer。

## 文件標準

- 根目錄 README 是入口頁，不塞完整教學正文。
- `docs/learning_path.md` 說明學習順序。
- `docs/sample_index.md` 列出所有範例入口。
- 每個完整 feature 都要有 `docs/features/<feature_name>.md`。
- 架構改動要同步更新 `docs/architecture_overview.md`。
- 測試策略改動要同步更新 `docs/testing_strategy.md`。

## 程式碼註解標準

- 註解以繁體中文為主，可以保留必要英文技術名詞，例如 Provider、Repository、ViewModel。
- 檔案或類別註解要說明它在架構中的角色。
- 複雜流程前要說明原因，例如為什麼 override provider、為什麼不直接打 API。
- 不替每一行簡單語法加註解，避免降低閱讀性。
- 測試檔使用 Arrange / Act / Assert 時，要搭配中文說明測試意圖。

## 新增範例流程

1. 先寫文件：說明這個範例要教什麼、不教什麼。
2. 新增最小可執行畫面。
3. 補 unit 或 widget test。
4. 在 `docs/sample_index.md` 加入索引。
5. 若是完整 feature，新增 `docs/features/<feature_name>.md`。
6. 跑 `flutter analyze` 與 `flutter test`。
7. 若本機不能跑 Flutter，推到 GitHub 後看 CI 結果。
