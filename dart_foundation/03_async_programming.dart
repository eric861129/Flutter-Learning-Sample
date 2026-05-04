/// Dart 基礎學習 - 第三課：非同步編程 (Asynchronous Programming)
/// 執行方式：在終端機輸入 `dart run dart_foundation/03_async_programming.dart`

/// 模擬一個網路請求，2 秒後回傳結果。
///
/// Future 代表「未來才會完成的一個值」。
/// 在 Flutter 中，API request、讀檔、本地資料庫操作通常都會回傳 Future。
Future<String> fetchUserData() async {
  print('正在獲取用戶數據...');
  await Future.delayed(Duration(seconds: 2));
  return 'User: Eric, ID: 861129';
}

/// 模擬一個資料流，每秒產生一個數字。
///
/// Stream 代表「一連串未來會陸續出現的值」。
/// 常見情境包含即時聊天、Socket、倒數計時、位置更新。
Stream<int> countStream(int max) async* {
  for (int i = 1; i <= max; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i; // yield 用於產生 Stream 的值
  }
}

/// 非同步範例入口。
///
/// main 可以標記為 async，這樣就能在裡面使用 await。
void main() async {
  print('--- 1. Future 與 async/await ---');
  print('開始程序');
  
  // 使用 await 等待結果，這會暫停 main 的執行直到結果回傳
  String data = await fetchUserData();
  print('獲取到數據: $data');
  
  print('\n--- 2. Stream (異步數據流) ---');
  print('開始計時...');
  // 使用 await for 監聽 Stream
  await for (int count in countStream(3)) {
    print('收到數字: $count');
  }

  print('\n程序結束');
  
  print('\n--- 學習重點 ---');
  print('1. Future 代表「未來的某個值」，常用於 API 請求。');
  print('2. Stream 代表「一連串異步發送的值」，常用於 Socket 或監聽按鈕點擊。');
  print('3. 標記 async 的函數必須回傳 Future 或 Stream。');
}
