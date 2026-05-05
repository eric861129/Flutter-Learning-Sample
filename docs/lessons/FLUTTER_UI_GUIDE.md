# Flutter UI 與元件指南 (UI & Widgets Guide)

本文件提供常用的 UI 元件範例程式碼，方便你直接複製使用。

## 1. 靜態與動態元件 (Stateless vs StatefulWidget)

```dart
// 1. 靜態元件：單純顯示資料
class InfoCard extends StatelessWidget {
  final String title;
  const InfoCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(title),
      ),
    );
  }
}

// 2. 動態元件：內容會改變
class LikeButton extends StatefulWidget {
  const LikeButton({super.key});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
      color: isLiked ? Colors.red : Colors.grey,
      onPressed: () {
        setState(() { // 關鍵：觸發重新渲染
          isLiked = !isLiked;
        });
      },
    );
  }
}
```

## 2. 佈局元件 (Layout)

```dart
Widget layoutDemo() {
  return Column(
    children: [
      // Row: 水平
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('左側文字'),
          ElevatedButton(onPressed: () {}, child: const Text('右側按鈕')),
        ],
      ),
      
      const SizedBox(height: 20), // 間距
      
      // Stack: 重疊
      Stack(
        children: [
          Container(width: 200, height: 200, color: Colors.blue),
          const Positioned(
            bottom: 10,
            right: 10,
            child: Text('我在右下角', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    ],
  );
}
```

## 3. 響應式佈局 (LayoutBuilder)

```dart
class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // 寬螢幕 (平板)
          return Row(children: [Expanded(child: Container(color: Colors.red))]);
        } else {
          // 窄螢幕 (手機)
          return Column(children: [Expanded(child: Container(color: Colors.red))]);
        }
      },
    );
  }
}
```

## 學完你應該能回答

- `StatelessWidget` 和 `StatefulWidget` 的差別是什麼？
- Flutter layout 中「constraints go down, sizes go up, parent sets position」代表什麼？
- 什麼情境適合用 `Row`、`Column`、`Stack`？
- `LayoutBuilder` 為什麼適合做響應式版面？

## 最小修改練習

1. 修改 `lib/01_basic_widgets.dart`，新增一個有 icon、文字與背景色的資訊卡。
2. 修改 `lib/03_layout_principles.dart`，讓其中一個 `Row` 改成可避免 overflow 的寫法。
3. 修改 `lib/04_responsive_layout.dart`，把寬版門檻從 600 調整成 720，觀察版面語意如何改變。

## 進階挑戰

1. 做一個同時支援手機與平板的 dashboard layout。
2. 在不寫死高度的前提下，讓卡片中的長文字能自然換行。
3. 寫一份學習筆記，解釋你第一次真正理解 Flutter layout constraints 的瞬間。
