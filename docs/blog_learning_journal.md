# Blog 學習紀錄模板

這份文件用來把學習 Flutter 的過程整理成 Blog 素材。建議每學完一個主題，就用同一個格式寫一篇短筆記，之後再擴寫成文章。

## 單篇文章模板

````markdown
# 標題：我用這個 sample 學會了 ______

## 這篇在解決什麼問題

我原本不懂的是：

- _待補_

這個主題在 Flutter 開發中重要，因為：

- _待補_

## 我先讀了哪些文件

- _待補_

## 我看的程式入口

- _待補_

## 我理解到的資料流 / UI 流程

```text
畫面或事件
  -> 狀態
  -> 資料來源
  -> 回到畫面
```

## 最容易卡住的地方

- _待補_

## 我用什麼測試確認理解

- _待補_

## 我下一篇要學什麼

- _待補_
````

## 學習日誌欄位

| 欄位 | 說明 |
| --- | --- |
| 日期 | 這次學習的日期 |
| 主題 | 例如 Dart、Widget、Router、Riverpod、Testing |
| 起點文件 | 這次從哪份 docs 開始 |
| 入口程式碼 | 第一個看的 `.dart` 檔 |
| 我學會了 | 用自己的話寫 3 點 |
| 我還不懂 | 留給下一次追的問題 |
| 下一步 | 下一個文件或下一個 sample |

## 推薦文章順序

1. 建立 Flutter 學習 sample repo 的原因。
2. Dart 基礎：為什麼 Flutter 開發不能跳過 Dart。
3. Widget 與 Layout：第一次理解 Flutter UI。
4. App shell：`main.dart`、router、theme 如何組成 app。
5. Feature-first：用 posts feature 理解分層。
6. Riverpod 與 Repository：讓畫面不直接依賴 API。
7. Widget test 與 fake repository：怎麼測 UI 而不打真 API。
8. 無 Flutter 本機環境：用 GitHub Actions 支援學習流程。

## 從專案回推文章的方式

寫文章時不要只貼程式碼，建議依照這個順序：

1. 先說明你遇到的學習問題。
2. 再指出 repo 裡哪份文件負責解釋這件事。
3. 接著打開一個最小程式入口。
4. 用資料流或 UI 流程說明它如何運作。
5. 最後用測試或 CI 說明你怎麼確認它沒有壞。

這樣文章就會像「學習過程紀錄」，而不是單純的 API 筆記。
