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

## 小白級註解標準

這個 repo 的註解要讓零基礎學習者看得懂。請用「帶讀」的語氣，說明設計意圖。

好的註解應該回答：

- 這段程式在整體架構中扮演什麼角色？
- 為什麼這裡用這個 Widget / class / provider？
- 如果把這段邏輯放到別層，會造成什麼問題？
- 初學者最容易誤會哪裡？

範例：

```dart
/// View 只負責畫畫面和接收點擊。
///
/// 這裡不要直接呼叫 API，因為一旦畫面自己打網路，
/// widget test 就會變慢、變不穩，也很難測錯誤狀態。
/// 所以我們把資料流程交給 ViewModel 和 Repository。
class PostListView extends ConsumerWidget {
  const PostListView({super.key});
}
```

另一個範例：

```dart
/// 更新搜尋文字。
///
/// 這裡使用 debounce，是因為使用者打字時通常會連續輸入好幾個字。
/// 如果每打一個字就立刻重新查詢，畫面會一直刷新，API 或 repository
/// 也會被呼叫太多次。等使用者停一下再查，體驗會比較穩定。
void updateSearchTerm(String value) {
  // 實作放在 ViewModel，View 只負責把輸入文字交過來。
}
```

不要寫成：

```dart
// 建立 PostListView
class PostListView extends ConsumerWidget {
  const PostListView({super.key});
}
```

第二種註解只是把程式碼翻成中文，沒有教學價值。

## 註解密度

- public class、provider、repository、ViewModel、重要 Widget 都要有註解。
- 一般變數或很直覺的 getter 不需要硬加註解。
- 複雜流程前可以加一段「這段在做什麼」。
- 不要每一行都註解，否則學習者會被文字淹沒。

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
