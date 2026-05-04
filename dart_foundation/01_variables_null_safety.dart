/// Dart 基礎學習 - 第一課：變數、類型與空安全 (Null Safety)
/// 執行方式：在終端機輸入 `dart run dart_foundation/01_variables_null_safety.dart`

/// 變數、型別與空安全範例入口。
void main() {
  print('--- 1. 變數聲明 (Variables) ---');
  
  // var: 自動推斷類型，一旦賦值後類型不可變
  var name = 'Eric'; 
  // name = 123; // 這會報錯，因為 name 已經被推斷為 String
  
  // final: 只能賦值一次的變數（運行時常量）
  final now = DateTime.now();
  
  // const: 編譯時常量，在編譯時就必須確定值
  const pi = 3.14159;
  
  print('Name: $name, Now: $now, PI: $pi');

  print('\n--- 2. 空安全 (Null Safety) ---');
  // Dart 預設所有變數都不能為 null
  // String title = null; // 這會報錯
  
  // 使用 ? 標示變數可以為 null (Nullable)
  String? nullableName = null;
  
  // 使用 ?? 提供預設值 (If null operator)
  String displayName = nullableName ?? 'Guest';
  print('Display Name: $displayName');
  
  // 使用 ! 強制標示不為 null (Assertion operator) - 請謹慎使用，若真的為 null 會崩潰
  // print(nullableName!.length); 
  
  // 使用 ?. 安全調用屬性 (Null-aware access)
  print('Name Length: ${nullableName?.length}'); // 會輸出 null 而不是報錯

  print('\n--- 學習重點 ---');
  print('1. 優先使用 final，除非變數需要重新賦值。');
  print('2. 盡量避免使用 !，多利用 ?? 或 ?. 來處理可能的 null。');
}
