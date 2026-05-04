import 'package:flutter_learning_sample/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  // IntegrationTestWidgetsFlutterBinding 讓測試能以接近真實 app 的方式執行。
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('home page shows the learning path', (tester) async {
    // App 使用 Riverpod，因此 integration test 也要包 ProviderScope。
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // 這裡只做最小煙霧測試：確認 app shell 能啟動並顯示首頁內容。
    expect(find.text('Flutter 學習路徑'), findsOneWidget);
    expect(find.text('基礎 UI'), findsOneWidget);
    expect(find.text('狀態與資料'), findsOneWidget);
  });
}
