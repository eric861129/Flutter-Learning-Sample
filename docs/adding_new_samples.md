# 新增範例規範

新增 Flutter 範例時，請把它當成一個小型官方 sample：範例要可讀、可跑、可測，並且清楚說明它教什麼。

## 目錄命名

功能型範例使用 feature-first：

```text
lib/features/<feature_name>/
  domain/
  data/
  presentation/
```

如果只是單頁 UI 展示，可以先放在：

```text
lib/views/
```

當 UI 展示開始需要資料、狀態或測試，就應該升級成 `features/<feature_name>/`。

## 每個 feature 必備文件資訊

在 `docs/features/<feature_name>.md` 說明：

- 學習目標
- 檔案地圖
- data flow
- 測試位置
- 學完你應該能回答
- 最小修改練習
- 進階挑戰

## 每個 feature 必備測試

至少包含：

- repository 或 data logic unit test
- ViewModel state test
- widget test

## 程式碼註解要求

本專案是教學知識庫，新增範例時請加入繁體中文註解：

- class 註解說明它在架構中的角色。
- provider 註解說明它建立或暴露什麼依賴。
- service/repository 註解說明資料從哪裡來、為什麼要分層。
- ViewModel 註解說明它管理哪些 UI state 與事件。
- widget test 註解說明 fake repository、provider override、pump 的目的。

註解要解釋「為什麼」，不要只重複程式碼表面語法。

## README 更新

新增範例後要同步：

- `README.md`
- `docs/sample_index.md`
- `PROJECT_STATUS.md`

## 不要做的事

- 不要把 token、金鑰、個資寫進範例。
- 不要讓 Widget 直接呼叫 Dio。
- 不要新增沒有測試的資料流程。
- 不要讓文件指向不存在的路徑。
