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
