# Flutter Widget 零基礎筆記：給 C# 開發者的第一輪複習

這份筆記整理進入 Flutter UI 前最重要的 Widget 觀念。目標是先學會閱讀 Widget tree，而不是一次背完所有元件。

## 這份筆記在專案中的位置

建議閱讀順序：

```text
docs/lessons/DART_ZERO_TO_ONE_CSHARP.md
  -> docs/lessons/WIDGET_ZERO_TO_ONE_CSHARP.md
  -> lib/views/home_page.dart
  -> lib/01_basic_widgets.dart
  -> docs/lessons/WIDGET_MENTAL_MODEL.md
```

對照專案檔案：

| 你正在學的概念                                       | 專案中的對照位置                      |
| ---------------------------------------------------- | ------------------------------------- |
| Widget tree、`Scaffold`、`ListView`                  | `lib/views/home_page.dart`            |
| `Text`、`Icon`、`Container`、`Row`、`Stack`、`Image` | `lib/01_basic_widgets.dart`           |
| `child` / `children`、`Padding`、`SizedBox`          | `lib/01_basic_widgets.dart`           |
| `onTap` 與導航事件                                   | `lib/views/home_page.dart`            |
| 下一步：完整 Widget 心智模型                         | `docs/lessons/WIDGET_MENTAL_MODEL.md` |

## 1. Widget 是什麼

在 Flutter 裡，畫面上的東西幾乎都是 Widget。

```dart
Text('Hello')
```

這是一個文字 Widget。

```dart
Icon(Icons.star)
```

這是一個圖示 Widget。

```dart
Column(
  children: [
    Text('Name'),
    Text('Eric'),
  ],
)
```

這是一個垂直排列 Widget，裡面放了兩個文字 Widget。

C# UI 類比：

| C# / XAML 概念        | Flutter 類比                      |
| --------------------- | --------------------------------- |
| `TextBlock` / `Label` | `Text`                            |
| `Button`              | `ElevatedButton` / `FilledButton` |
| 垂直 `StackPanel`     | `Column`                          |
| 水平 `StackPanel`     | `Row`                             |
| Page / Window 的骨架  | `Scaffold`                        |

## 2. 把 Widget 程式碼看成樹

Flutter 程式碼不要只看成一堆巢狀括號，要把它翻成 Widget tree。

```dart
Column(
  children: [
    Text('Name'),
    Text('Eric'),
  ],
)
```

樹狀結構：

```text
Column
  -> Text('Name')
  -> Text('Eric')
```

專案中的 `lib/01_basic_widgets.dart` 可以先看成：

```text
BasicWidgetsDemo
  -> Scaffold
    -> AppBar
      -> Text
    -> SingleChildScrollView
      -> Column
        -> Container
        -> Row
        -> SizedBox
        -> Stack
        -> SizedBox
        -> Image
```

## 3. child 與 children

Flutter 裡常看到：

```dart
child
children
```

差別很簡單：

```text
child    只能放一個 Widget
children 可以放多個 Widget
```

`Center` 只能置中一個東西，所以用 `child`。

```dart
Center(
  child: Text('Hello'),
)
```

`Column` 可以垂直排列多個東西，所以用 `children`。

```dart
Column(
  children: [
    Text('Title'),
    Text('Subtitle'),
  ],
)
```

C# 類比：

```text
child    像 ContentControl.Content，只能一個內容
children 像 Panel.Children，可以很多個子元件
```

常見組合：

```dart
Center(
  child: Column(
    children: [
      Text('Hello'),
      Text('Flutter'),
    ],
  ),
)
```

樹狀結構：

```text
Center
  -> Column
    -> Text('Hello')
    -> Text('Flutter')
```

## 4. Scaffold 是頁面骨架

`Scaffold` 可以想成 Material App 裡的標準頁面框架。

```dart
Scaffold(
  appBar: AppBar(
    title: Text('Demo'),
  ),
  body: Center(
    child: Text('Hello'),
  ),
)
```

樹狀結構：

```text
Scaffold
  appBar -> AppBar
    title -> Text('Demo')
  body -> Center
    child -> Text('Hello')
```

`Scaffold` 常見插槽：

```text
appBar               頂部列
body                 主要內容
floatingActionButton 右下角浮動按鈕
drawer               側邊選單
bottomNavigationBar  底部導航
```

注意：`appBar`、`body` 不是 `child`，而是 `Scaffold` 提供的命名插槽。

## 5. StatelessWidget 與 build()

你可以自己建立 Widget。

```dart
class BasicWidgetsDemo extends StatelessWidget {
  const BasicWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('基礎元件 Demo')),
      body: const Text('Hello'),
    );
  }
}
```

這行代表：

```dart
class BasicWidgetsDemo extends StatelessWidget
```

```text
BasicWidgetsDemo 是一個自訂 Widget
它繼承 StatelessWidget
```

`StatelessWidget` 可以先理解成：

```text
自己不保存會改變的狀態，只負責根據目前資料畫出 UI。
```

`build()` 的責任：

```text
回傳這個 Widget 要顯示的 Widget tree。
```

Flutter 會呼叫：

```dart
Widget build(BuildContext context)
```

然後期待你回傳一個 Widget。

## 6. BuildContext 是什麼

初學先這樣記：

```text
BuildContext 代表這個 Widget 在 Widget tree 裡的位置。
```

它是 Flutter 給你的目前所在節點資訊，可以用來取得目前環境。

專案首頁有：

```dart
final theme = Theme.of(context);
```

意思是：

```text
從目前 Widget 所在的 context，往上找到最近的 Theme，拿到顏色、文字樣式等設定。
```

常見用法：

```dart
Theme.of(context)              // 取得目前主題
Navigator.of(context)          // 取得導航器
MediaQuery.of(context)         // 取得螢幕尺寸等資訊
ScaffoldMessenger.of(context)  // 顯示 SnackBar
```

`BuildContext` 不是資料模型，也不是 controller。它是 Widget 在樹裡的位置與環境入口。

## 7. const Widget

Flutter 裡很常看到：

```dart
const Text('Hello')
const Icon(Icons.star)
const SizedBox(height: 20)
```

`const` 代表這個 Widget 的建構參數在編譯時就能確定。

可以加 `const`：

```dart
const Text('Hello')
```

通常不能加 `const`：

```dart
Text(title)
```

因為 `title` 是變數，要等執行時才知道內容。

初學先記：

```text
固定不變的 Widget，能加 const 就加 const。
```

## 8. Row / Column 的 mainAxis 與 crossAxis

`Column` 是垂直排列。

```text
Column
  mainAxis  = 垂直方向
  crossAxis = 水平方向
```

`Row` 是水平排列。

```text
Row
  mainAxis  = 水平方向
  crossAxis = 垂直方向
```

專案首頁有：

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(...),
    ListTile(...),
    Divider(),
  ],
)
```

意思是：

```text
Column 由上到下排 children
crossAxisAlignment.start 讓內容在水平方向靠左開始
```

`Row` 範例：

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Icon(Icons.star),
    Icon(Icons.star),
    Icon(Icons.star),
  ],
)
```

意思是：

```text
Row 水平排列三個 Icon
mainAxisAlignment.spaceEvenly 讓它們在水平方向平均分布
```

## 9. Padding、margin、SizedBox

Flutter 裡空間也常常是 Widget 或 Widget 的屬性。

```text
Padding   內距，包住 child，讓內容離邊界遠一點
margin    外距，通常在 Container 裡設定
SizedBox  固定寬高，常用來做間距
```

`Padding`：

```dart
Padding(
  padding: EdgeInsets.all(16),
  child: Text('Hello'),
)
```

`Container` 的 `margin` 與 `padding`：

```dart
Container(
  margin: EdgeInsets.all(16),
  padding: EdgeInsets.all(20),
  child: Text('Hello'),
)
```

白話：

```text
margin  = Container 外面，和其他 Widget 之間的距離
padding = Container 裡面，邊界和 child 之間的距離
```

`SizedBox` 常用來單純留空：

```dart
const SizedBox(height: 20)
```

如果只是想在兩個 `Text` 中間留 20 高度，較適合用 `SizedBox(height: 20)`，而不是 `Container(height: 20)`。

## 10. Container

`Container` 是初學者常用的容器，因為它一次能做很多事：

```text
設定寬高
設定 padding
設定 margin
設定背景色
設定邊框
設定圓角
設定陰影
包住一個 child
```

專案範例：

```dart
Container(
  margin: const EdgeInsets.all(16),
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(10),
    boxShadow: const [
      BoxShadow(blurRadius: 5, color: Colors.grey),
    ],
  ),
  child: const Text(
    '我是 Container',
    style: TextStyle(color: Colors.white),
  ),
)
```

樹狀結構：

```text
Container
  -> Text
```

外觀設定在 `Container` 自己身上：

```text
margin
padding
decoration
```

初學先記：

```text
需要背景色、邊框、圓角、陰影、寬高時，用 Container 很合理。
只是留白時，Padding / SizedBox 通常更直覺。
```

## 11. ListView

`ListView` 可以先理解成：

```text
可以捲動的垂直清單
```

C# 類比：

```text
ListView / ItemsControl + ScrollViewer
```

`Column` 和 `ListView` 都能垂直放多個 children。

```text
Column   = 只負責垂直排列
ListView = 垂直排列 + 可捲動
```

專案首頁：

```dart
body: ListView(
  padding: const EdgeInsets.only(bottom: 24),
  children: [
    _buildSection(...),
    _buildSection(...),
  ],
)
```

意思是：

```text
首頁主內容是一個可捲動清單
裡面有兩個區塊：基礎 UI、狀態與資料
```

如果頁面有很多內容，可能超出手機高度，優先考慮 `ListView`。

## 12. ListTile

`ListTile` 是 Material Design 裡常用的清單列。

常見區域：

```text
leading   左側圖示或頭像
title     主標題
subtitle  副標題
trailing  右側圖示或文字
onTap     點擊事件
```

範例：

```dart
ListTile(
  leading: Icon(Icons.book),
  title: Text('Dart 基礎'),
  subtitle: Text('變數、型別、Null Safety'),
  trailing: Icon(Icons.chevron_right),
  onTap: () {
    print('clicked');
  },
)
```

專案首頁：

```dart
ListTile(
  title: Text(item.title),
  trailing: const Icon(Icons.chevron_right),
  onTap: () => context.push(item.path),
)
```

意思是：

```text
顯示一列學習項目
title 顯示項目名稱
右邊放 chevron_right 圖示
點下去切換到 item.path 對應頁面
```

## 13. onTap / onPressed 事件

Flutter 的事件處理很像 C# 的 click handler，只是寫法更函式化。

```dart
ElevatedButton(
  onPressed: () {
    print('clicked');
  },
  child: Text('Click me'),
)
```

`onPressed` 接收一個函式，等按鈕被按下時才執行。

專案首頁用的是：

```dart
onTap: () => context.push(item.path),
```

意思是：

```text
當這列被點擊時，切換到 item.path 對應的頁面。
```

這裡的：

```dart
() => context.push(item.path)
```

是一個沒有參數的匿名函式。不是立刻執行，而是等使用者點擊時才執行。

不要寫成：

```dart
onTap: context.push(item.path)
```

因為這會變成「現在就呼叫 `context.push(item.path)`」，不是「點擊時才呼叫」。

## 14. 閱讀 HomePage

專案首頁外層：

```dart
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter 學習路徑')),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          _buildSection(...),
          _buildSection(...),
        ],
      ),
    );
  }
}
```

樹狀結構：

```text
HomePage
  -> Scaffold
    appBar -> AppBar
      title -> Text('Flutter 學習路徑')
    body -> ListView
      -> _buildSection('基礎 UI')
      -> _buildSection('狀態與資料')
```

`_LearningItem` 是一個小型資料類別：

```dart
class _LearningItem {
  const _LearningItem(this.title, this.path);

  final String title;
  final String path;
}
```

例如：

```dart
_LearningItem('UI 元件庫', '/ui-kit')
```

代表：

```text
title = 'UI 元件庫'
path  = '/ui-kit'

畫面上顯示「UI 元件庫」
使用者點擊後導航到 /ui-kit
```

`_buildSection` 的核心：

```dart
return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(...),
    if (header != null) header,
    for (final item in items)
      ListTile(...),
    const Divider(),
  ],
);
```

樹狀結構：

```text
Column
  -> Padding
    -> Text(title)
  -> header 如果不是 null，才放進來
  -> 對每個 item 建立一個 ListTile
  -> Divider
```

這段：

```dart
for (final item in items)
  ListTile(
    title: Text(item.title),
  )
```

代表：

```text
把 items 裡每個 item 都轉成一個 ListTile。
```

這就是 Flutter 很常見的模式：

```text
資料列表 -> 多個 Widget
```

## 本章總結

- Widget 是 Flutter 的畫面描述物件。
- Widget 程式碼要翻成 Widget tree 來讀。
- `child` 放一個 Widget，`children` 放多個 Widget。
- `Scaffold` 是標準頁面骨架。
- `StatelessWidget` 的 `build()` 負責回傳 UI tree。
- `BuildContext` 是 Widget 在 tree 裡的位置與環境入口。
- 固定不變的 Widget 適合加 `const`。
- `Row` 的主軸是水平，`Column` 的主軸是垂直。
- `Padding`、`margin`、`SizedBox` 都和留白有關，但語意不同。
- `Container` 適合處理容器外觀。
- `ListView` 是可捲動清單。
- `ListTile` 是常見清單列。
- `onTap` / `onPressed` 要接收「之後才執行」的函式。

## 練習題

1. 把 `Column(children: [Text('A'), Text('B')])` 畫成樹狀結構。
2. `child` 和 `children` 差在哪裡？
3. `Scaffold` 的 `appBar` 和 `body` 分別負責什麼？
4. `build()` 在 `StatelessWidget` 裡負責什麼？
5. `Theme.of(context)` 大概是在取得什麼？
6. 為什麼 `Text('Hello')` 可以加 `const`，但 `Text(title)` 通常不行？
7. 對 `Row` 來說，`mainAxis` 是水平還是垂直？
8. 如果只是要在兩個 Widget 中間留 20 高度，為什麼 `SizedBox(height: 20)` 比 `Container(height: 20)` 更清楚？
9. `ListView` 和 `Column` 的主要差異是什麼？
10. 為什麼 `onTap` 要寫成 `() => context.push(...)`？
