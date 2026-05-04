/// Dart 基礎學習 - 第二課：集合 (Collections)
/// 執行方式：在終端機輸入 `dart run dart_foundation/02_collections.dart`

/// 集合範例入口。
///
/// 這個範例集中展示 List、Set、Map 與常用集合轉換方法。
void main() {
  print('--- 1. List (列表/陣列) ---');
  var fruits = ['Apple', 'Banana', 'Orange'];
  fruits.add('Mango');
  print('Fruits: $fruits');
  print('First fruit: ${fruits[0]}');
  
  // Spread operator (...) 用於展開集合
  var moreFruits = ['Grape', ...fruits];
  print('More Fruits: $moreFruits');

  print('\n--- 2. Set (集合 - 元素不重複) ---');
  var uniqueNumbers = {1, 2, 3, 3, 2, 1};
  print('Unique Numbers: $uniqueNumbers'); // 只會顯示 {1, 2, 3}

  print('\n--- 3. Map (鍵值對) ---');
  var user = {
    'id': 1,
    'name': 'Eric',
    'isVIP': true,
  };
  print('User Name: ${user['name']}');
  
  print('\n--- 4. 集合操作 (FP style) ---');
  var numbers = [1, 2, 3, 4, 5, 6];
  
  // map: 轉換元素
  var doubled = numbers.map((n) => n * 2).toList();
  print('Doubled: $doubled');
  
  // where: 過濾元素 (類似 filter)
  var even = numbers.where((n) => n % 2 == 0).toList();
  print('Even numbers: $even');

  print('\n--- 學習重點 ---');
  print('1. List 是最常用的集合。');
  print('2. Map 常用於解析 JSON。');
  print('3. 熟練 map 和 where 可以大幅精簡代碼。');
}
