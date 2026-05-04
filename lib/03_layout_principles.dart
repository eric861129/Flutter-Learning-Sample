import 'package:flutter/material.dart';

/// Flutter 第二階段 - 第三課：佈局原理 (Layout Principles)
/// 核心概念：Constraints go down. Sizes go up. Parent sets position.
///
/// 這個範例故意設定誇張的寬高，讓你觀察 constraints 如何修正尺寸。
class LayoutPrinciplesDemo extends StatelessWidget {
  const LayoutPrinciplesDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('佈局原理')),
      body: Center(
        // Center 會讓 child 在可用空間中置中，但不會強迫 child 填滿空間。
        child: Container(
          color: Colors.grey[200],
          // 這裡 Container 的大小受父元件 (Center) 與 子元件的約束影響
          child: ConstrainedBox(
            // ConstrainedBox 明確限制子元件的最小/最大尺寸。
            constraints: const BoxConstraints(
              minWidth: 70,
              minHeight: 70,
              maxWidth: 150,
              maxHeight: 150,
            ),
            child: Container(
              color: Colors.red,
              width: 10, // 雖然設為 10，但會被 ConstrainedBox 的 minWidth (70) 強制修正
              height: 1000, // 雖然設為 1000，但會被 maxHeight (150) 強制修正
            ),
          ),
        ),
      ),
    );
  }
}

/*
💡 佈局三部曲：
1. Constraints go down (約束向下傳遞)：
   父元件告訴子元件：「你可以是 0~150 寬，0~150 高」。
2. Sizes go up (尺寸向上回傳)：
   子元件決定自己的尺寸：「好的，我要 150x150」。
3. Parent sets position (父元件決定位置)：
   父元件 (Center) 決定把子元件放在哪裡。
*/
