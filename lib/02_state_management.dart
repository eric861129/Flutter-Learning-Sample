import 'package:flutter/material.dart';

/// Flutter 第二階段 - 第二課：狀態管理基礎 (State Management)
/// 區分 StatelessWidget 與 StatefulWidget。

// 1. StatelessWidget: 靜態內容，一旦建立就不會改變（除非父元件重新建立）
// 適合用來顯示由外部傳入、自己不修改的資料。
/// 靜態文字元件。
///
/// StatelessWidget 沒有自己的可變狀態，適合用來呈現外部傳入的資料。
class StaticText extends StatelessWidget {
  final String text;
  const StaticText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}

// 2. StatefulWidget: 動態內容，內部狀態改變時會觸發重新渲染 (setState)
// 適合用來學習最基本的「畫面內部狀態」。
/// 計數器元件。
///
/// 這是最小的 StatefulWidget 範例，用來示範 `setState` 如何更新畫面。
class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

/// CounterWidget 對應的 State。
///
/// State 物件保存 `_counter`，並透過 `setState` 通知 Flutter 重建畫面。
class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0; // 這是狀態

  void _increment() {
    setState(() {
      // 呼叫 setState 會告訴 Flutter：狀態變了，請重新執行 build 方法
      // 注意：只要是會影響畫面的 state 變更，都要放在 setState 裡。
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('目前計數: $_counter', style: const TextStyle(fontSize: 24)),
        ElevatedButton(
          onPressed: _increment,
          child: const Text('點我增加'),
        ),
      ],
    );
  }
}
