import 'package:flutter/material.dart';

/// Flutter 第二階段 - 第四課：響應式佈局 (Responsive Layout)
/// 讓 APP 在不同螢幕尺寸下都能正常運作。
///
/// 這裡用 LayoutBuilder 示範「根據可用寬度切換版型」。
class ResponsiveDemo extends StatelessWidget {
  const ResponsiveDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('響應式佈局')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // 根據父元件傳下來的約束 (螢幕寬度) 來決定 UI
          // 這種寫法比直接讀取螢幕寬度更彈性，因為它回應的是父層給的空間。
          if (constraints.maxWidth > 600) {
            // 寬螢幕 (平板/電腦)
            return _buildWideLayout();
          } else {
            // 窄螢幕 (手機)
            return _buildMobileLayout();
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout() {
    // 手機版用單欄列表，符合窄螢幕的閱讀方式。
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => ListTile(title: Text('手機版項目 $index')),
    );
  }

  Widget _buildWideLayout() {
    // 寬螢幕用 GridView，讓橫向空間被更有效利用。
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: 10,
      itemBuilder: (context, index) => Card(child: Center(child: Text('平板版項目 $index'))),
    );
  }
}
