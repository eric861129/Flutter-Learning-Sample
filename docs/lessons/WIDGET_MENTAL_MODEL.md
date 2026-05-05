# Widget 心智模型：Everything is a Widget

在 Flutter 的世界裡，第一個要跨過的門檻就是：

> Everything is a Widget.

這句話不是口號，而是一種 UI 思維。Flutter 的畫面不是分成 HTML、CSS、controller、layout file，而是由一棵 Widget tree 組出來。

## 為什麼一切皆 Widget

在 Flutter 中，這些都是 Widget：

- App 本身：`MaterialApp`
- 頁面骨架：`Scaffold`
- 頂部列：`AppBar`
- 文字：`Text`
- 按鈕：`ElevatedButton`、`FilledButton`
- 圖示：`Icon`
- 間距：`SizedBox`
- 排版：`Row`、`Column`、`Stack`
- 捲動：`ListView`
- 表單欄位：`TextFormField`

所以 Flutter UI 的核心不是「畫一個畫面」，而是「組一棵 Widget tree」。

## Widget Tree

例如：

```dart
Scaffold(
  appBar: AppBar(
    title: const Text('Flutter 學習路徑'),
  ),
  body: Center(
    child: Column(
      children: [
        const Text('Hello Flutter'),
        FilledButton(
          onPressed: () {},
          child: const Text('開始學習'),
        ),
      ],
    ),
  ),
)
```

可以理解成：

```text
Scaffold
  -> AppBar
    -> Text
  -> Center
    -> Column
      -> Text
      -> FilledButton
        -> Text
```

當你看 Flutter 程式碼看到很多巢狀括號時，不要先害怕。先把它翻成樹狀結構，就會比較容易理解每一層在做什麼。

## StatelessWidget

`StatelessWidget` 適合「資料進來，畫面顯示，自己不保存狀態」的情境。

```dart
class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title);
  }
}
```

適合：

- 標題
- 靜態資訊卡
- 單純顯示資料的清單項目
- 從 parent 接收資料後呈現的 widget

## StatefulWidget

`StatefulWidget` 適合「畫面自己需要保存短期 UI 狀態」的情境。

```dart
class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}
```

適合：

- 計數器
- 展開 / 收合
- 使用者正在輸入的暫時狀態
- animation controller

但不是所有狀態都應該放在 `StatefulWidget`。

如果狀態需要跨頁共享、來自 API、需要測試、需要被多個 widget 使用，就應該考慮 ViewModel、Riverpod 或 Repository。

## 常見 Widget 類型

| 類型 | 常見 Widget | 用途 |
| --- | --- | --- |
| App shell | `MaterialApp`, `Scaffold`, `AppBar` | 建立 app 與頁面骨架 |
| Layout | `Row`, `Column`, `Stack`, `Expanded`, `Padding` | 決定排列方式 |
| Content | `Text`, `Image`, `Icon` | 顯示內容 |
| Input | `TextField`, `TextFormField`, `Checkbox`, `Switch` | 接收使用者輸入 |
| Feedback | `SnackBar`, `Dialog`, `CircularProgressIndicator` | 顯示結果、警告或載入 |
| Scroll | `ListView`, `GridView`, `SingleChildScrollView` | 處理超出畫面的內容 |

## 什麼時候要拆 Widget

當你看到這些訊號，就可以考慮拆成小 Widget：

- `build()` 超過一個螢幕還看不完。
- 同一段 UI 重複出現。
- 某一小塊 UI 有清楚名稱，例如 `LearningItemTile`。
- 你想單獨測某一塊 UI。
- parent widget 開始同時處理 layout、資料、事件、樣式。

拆 Widget 不是為了炫技，而是讓畫面變得可讀、可維護、可測試。

## AI 如何幫助理解 Widget

學 Flutter 時，AI 很適合當 Widget tree 的翻譯器。

你可以請 AI 幫你：

- 把巢狀 Widget 轉成樹狀圖。
- 解釋每個 Widget 的責任。
- 比較 `Row`、`Column`、`Stack`、`ListView` 的使用時機。
- 判斷哪一段 UI 應該拆成小 Widget。
- 幫程式碼補繁體中文教學註解。

這讓學習不只是抄程式，而是理解每一層 Widget 為什麼存在。

## 常見雷點

- 把 Widget tree 當成一大串括號看，沒有轉成樹狀結構。
- 所有畫面都塞在同一個 `build()` 裡。
- 把 API state、form state、navigation state 全部放進 `StatefulWidget`。
- 用固定寬高硬排 layout。
- 不知道 `const` widget 可以減少不必要 rebuild。

## 學完你應該能回答

- 「Everything is a Widget」真正代表什麼？
- Widget tree 和一般畫面配置檔有什麼不同？
- `StatelessWidget` 和 `StatefulWidget` 的差別是什麼？
- 什麼情境下狀態不應該放在 `StatefulWidget`？
- 什麼時候應該把一段 UI 拆成小 Widget？

## 最小修改練習

1. 打開 `lib/views/home_page.dart`，畫出目前首頁的 Widget tree。
2. 在 `lib/01_basic_widgets.dart` 新增一個小型 `StatelessWidget`，用來顯示一張資訊卡。
3. 在 `lib/02_state_management.dart` 找出 `StatefulWidget` 保存的狀態，寫下它為什麼需要 state。

## 進階挑戰

1. 把 `lib/views/ui_kit_view.dart` 中任一區塊拆成獨立小 Widget。
2. 替拆出的 Widget 補一個 widget test。
3. 寫一篇 Blog，解釋你如何從「巢狀括號」看懂 Flutter Widget tree。
