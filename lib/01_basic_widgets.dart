import 'package:flutter/material.dart';

/// Flutter 第二階段 - 第一課：基礎元件 (Basic Widgets)
/// 這裡是 Flutter UI 的磚塊。
///
/// 本頁把常見基礎 Widget 放在同一個畫面中，方便初學者對照。
class BasicWidgetsDemo extends StatelessWidget {
  const BasicWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('基礎元件 Demo')),
      // SingleChildScrollView 讓內容超過螢幕高度時可以捲動。
      body: SingleChildScrollView(
        // Column 會把 children 由上到下排列。
        child: Column(
          children: [
            // 1. Container: 就像 HTML 的 <div>，最常用的容器
            // 可以同時控制 margin、padding、背景色、圓角、陰影等外觀。
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.grey)],
              ),
              child: const Text('我是 Container', style: TextStyle(color: Colors.white)),
            ),

            // 2. Row: 水平排列
            // mainAxisAlignment 決定水平方向如何分配空間。
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.star, color: Colors.red),
                Icon(Icons.star, color: Colors.green),
                Icon(Icons.star, color: Colors.blue),
              ],
            ),

            const SizedBox(height: 20), // 用來留白

            // 3. Stack: 堆疊排列 (後面的蓋在前面的上面)
            // 常用於圖片上放 badge、按鈕、標籤等重疊 UI。
            Stack(
              alignment: Alignment.center,
              children: [
                Container(width: 100, height: 100, color: Colors.yellow),
                const Positioned(
                  top: 10,
                  right: 10,
                  child: CircleAvatar(radius: 10, backgroundColor: Colors.red),
                ),
                const Text('Stack 堆疊'),
              ],
            ),

            const SizedBox(height: 20),

            // 4. Image: 顯示圖片
            // Image.network 適合教學展示；正式 app 通常要處理 loading/error/快取。
            Image.network(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
