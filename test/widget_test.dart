import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// 一個簡單的計數器 App 元件，用於示範 Widget Test。
///
/// 這個測試元件刻意寫在 test 檔裡，讓初學者可以專注理解測試流程，
/// 不需要先跳到正式 app 的架構。
class TestCounterApp extends StatefulWidget {
  const TestCounterApp({super.key});

  @override
  State<TestCounterApp> createState() => _TestCounterAppState();
}

/// TestCounterApp 對應的 State。
///
/// 測試會透過點擊按鈕確認這個 State 是否正確觸發畫面更新。
class _TestCounterAppState extends State<TestCounterApp> {
  // 測試會驗證這個 count 是否因按鈕點擊而改變。
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text('Count: $count'),
              ElevatedButton(
                // setState 會觸發 widget rebuild，測試中要搭配 tester.pump。
                onPressed: () => setState(() => count++),
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  // 這是一個「元件測試 (Widget Test)」範例
  testWidgets('計數器應從 0 開始，點擊按鈕後變為 1', (WidgetTester tester) async {
    // 1. 在測試環境中渲染我們的 APP
    await tester.pumpWidget(const TestCounterApp());

    // 2. 驗證初始文字是否為 Count: 0
    expect(find.text('Count: 0'), findsOneWidget);
    expect(find.text('Count: 1'), findsNothing);

    // 3. 尋找按鈕並點擊
    await tester.tap(find.byType(ElevatedButton));

    // 4. 重點：這會觸發畫面更新，必須呼叫 pump()
    // pump 會讓 Flutter 測試環境處理 setState 後的下一次 build。
    await tester.pump();

    // 5. 驗證點擊後的文字
    expect(find.text('Count: 0'), findsNothing);
    expect(find.text('Count: 1'), findsOneWidget);
  });
}
