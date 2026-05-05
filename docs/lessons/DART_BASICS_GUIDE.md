# Dart 基礎編程指南 (Dart Basics Guide)

本文件提供完整的代碼範例，幫助你快速掌握 Dart 核心語法。

## 1. 變數與類型 (Variables)

```dart
void variableDemo() {
  // 推斷類型
  var name = 'Eric'; 
  
  // 明確類型 (推薦用於複雜邏輯)
  String city = 'Taipei';
  int age = 25;
  
  // 唯讀變數
  final double pi = 3.14159; // 運行時確定
  const int maxCount = 100; // 編譯時確定
  
  print('$name lives in $city, age $age. PI is $pi');
}
```

## 2. 空安全 (Null Safety)

```dart
void nullSafetyDemo() {
  // 可為空的變數用 ?
  String? username; 
  
  // 安全調用 ?.
  print(username?.length); // 輸出 null 而不報錯
  
  // 預設值處理 ??
  String displayName = username ?? '匿名用戶';
  
  // 串接使用
  String result = username?.toUpperCase() ?? 'NONE';
  
  print('Result: $result');
}
```

## 3. 異步編程 (Async/Await)

```dart
// 定義一個返回 Future 的函數
Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 2)); // 模擬延遲
  return '數據下載成功';
}

void main() async {
  print('正在請求...');
  
  try {
    // 等待結果
    String result = await fetchData();
    print(result);
  } catch (e) {
    print('出錯了: $e');
  }
}
```

## 4. 物件導向與封閉類別 (OOP & Sealed Classes)

```dart
// 定義狀態
sealed class Result {}

class Success extends Result {
  final String data;
  Success(this.data);
}

class Error extends Result {
  final String message;
  Error(this.message);
}

// 使用模式匹配處理結果
String handleResult(Result res) {
  return switch (res) {
    Success(data: var d) => '成功: $d',
    Error(message: var m) => '失敗: $m',
  };
}
```

## 學完你應該能回答

- `final` 和 `const` 的差別是什麼？
- nullable type 和 non-nullable type 如何影響程式安全性？
- `async` / `await` 解決了什麼問題？
- sealed class 搭配 pattern matching 適合表示哪些狀態？

## 最小修改練習

1. 在 `dart_foundation/01_variables_null_safety.dart` 新增一個 nullable `String? nickname`，並用 `??` 提供預設值。
2. 在 `dart_foundation/03_async_programming.dart` 新增一個模擬延遲載入使用者資料的 `Future<String>`。
3. 在 `dart_foundation/04_oop_advanced.dart` 新增一個 `Loading extends Result`，並更新 `handleResult`。

## 進階挑戰

1. 設計一個 `sealed class ApiResult<T>`，包含 loading、success、failure 三種狀態。
2. 用 pattern matching 把 `ApiResult<T>` 轉成可顯示在 UI 上的文字。
3. 寫一段簡短筆記，說明為什麼 Flutter app 常用 sealed class 或 enum 表示 UI state。
