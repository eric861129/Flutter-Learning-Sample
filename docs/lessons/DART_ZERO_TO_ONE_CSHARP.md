# Dart 零基礎語法筆記：給 C# 開發者的第一輪複習

這份筆記整理第一次進入 Flutter 前需要先懂的 Dart 語法。目標不是背完整語言規格，而是先建立能閱讀 Flutter 專案的最低心智模型。

## 這份筆記在專案中的位置

建議閱讀順序：

```text
docs/lessons/DART_ZERO_TO_ONE_CSHARP.md
  -> dart_foundation/01_variables_null_safety.dart
  -> dart_foundation/02_collections.dart
  -> lib/features/posts/domain/post.dart
  -> docs/lessons/WIDGET_MENTAL_MODEL.md
```

對照專案檔案：

| 你正在學的概念 | 專案中的對照位置 |
| --- | --- |
| `var`、`final`、`const`、null safety | `dart_foundation/01_variables_null_safety.dart` |
| `List`、`Map`、collection 操作 | `dart_foundation/02_collections.dart` |
| `class`、`fromJson`、強型別 model | `lib/features/posts/domain/post.dart` |
| API JSON 轉 model | `lib/features/posts/data/post_api_service.dart` |
| 下一步：Widget 心智模型 | `docs/lessons/WIDGET_MENTAL_MODEL.md` |

## 1. 變數：var、final、const

### var：讓 Dart 自動判斷型別

```dart
void main() {
  var name = 'Eric';

  print(name);
}
```

`var` 不是「任意型別」。Dart 會根據第一次指定的值推斷型別。

```dart
void main() {
  var name = 'Eric';

  name = 123; // 錯誤：name 已經被推斷成 String
}
```

### final：只能指定一次

```dart
void main() {
  final name = 'Eric';

  name = 'Amy'; // 錯誤：final 變數不能重新指定
}
```

`final` 很常出現在 Flutter 專案中，代表這個變數建立後不應該被重新指定。

### const：編譯時就固定的常數

```dart
void main() {
  const pi = 3.14159;

  print(pi);
}
```

`const` 比 `final` 更嚴格，值必須在編譯時就能確定。

```dart
void main() {
  final now = DateTime.now(); // 可以：執行時才知道現在時間

  const invalidNow = DateTime.now(); // 錯誤：編譯時無法知道現在時間
}
```

| 寫法 | 意思 | 能不能重新指定 |
| --- | --- | --- |
| `var name = 'Eric';` | 自動判斷型別 | 可以 |
| `final name = 'Eric';` | 只能指定一次 | 不可以 |
| `const pi = 3.14;` | 編譯時常數 | 不可以 |

## 2. 常見型別

```dart
void main() {
  String name = 'Eric';   // 文字
  int age = 18;           // 整數
  double height = 175.5;  // 小數，64-bit 浮點數
  bool isStudent = true;  // true / false

  print(name);
  print(age);
  print(height);
  print(isStudent);
}
```

| Dart | C# 類比 | 用途 |
| --- | --- | --- |
| `String` | `string` | 文字 |
| `int` | `int` | 整數 |
| `double` | `double` | 浮點數 |
| `bool` | `bool` | 布林值 |
| `num` | 數字共同父型別 | 可放 `int` 或 `double` |

Dart 的型別名稱多數是小寫，例如 `double`，不是 `Double`。

```dart
double amount = 12.5; // 正確
```

## 3. double 與金額精度

Dart 的 `double` 和 C# 的 `double` 一樣，都是二進位浮點數，所以也會遇到精度問題。

```dart
void main() {
  double d = 0.1 + 0.2;

  print(d == 0.3); // false
  print(d);        // 0.30000000000000004
}
```

C# 可以用 `decimal` 處理高精度十進位金額，但 Dart 標準語言沒有內建 `decimal`。在 Flutter App 中處理金額時，常見做法是用最小單位的整數儲存。

```dart
void main() {
  int priceInCents = 12550; // 代表 125.50 元
  int shippingInCents = 3000;

  int totalInCents = priceInCents + shippingInCents;

  print(totalInCents); // 15550
}
```

需要顯示時再格式化：

```dart
void main() {
  int totalInCents = 15550;

  String display = '\$${(totalInCents / 100).toStringAsFixed(2)}';

  print(display); // $155.50
}
```

## 4. Null Safety：空值安全

Dart 預設變數不能是 `null`。

```dart
void main() {
  String name = null; // 錯誤
}
```

如果一個變數允許是 `null`，要加上 `?`。

```dart
void main() {
  String? nickname = null; // 可以
}
```

可以這樣記：

```text
String  代表一定有字串
String? 代表可能有字串，也可能是 null
```

### `??`：如果是 null，就用預設值

```dart
void main() {
  String? nickname = null;

  String displayName = nickname ?? 'Guest';

  print(displayName); // Guest
}
```

### `?.`：如果不是 null，才繼續取屬性

```dart
void main() {
  String? nickname = null;

  print(nickname?.length); // null
}
```

### `!`：我保證它不是 null

```dart
void main() {
  String? nickname = 'Eric';

  print(nickname!.length); // 4
}
```

如果保證錯了，會在執行時出錯。

```dart
void main() {
  String? nickname = null;

  print(nickname!.length); // 執行時錯誤
}
```

初學階段先記：優先使用 `??` 或 `?.`，少用 `!`。

## 5. 函式 function

函式就是把一段邏輯包起來，之後可以重複呼叫。

```dart
void sayHello() {
  print('Hello');
}
```

`void` 代表這個函式不回傳值。

```dart
void main() {
  sayHello();
}

void sayHello() {
  print('Hello');
}
```

有回傳值與參數的函式：

```dart
String greet(String name) {
  return 'Hello, $name';
}
```

C# 類比：

```csharp
string Greet(string name)
{
    return $"Hello, {name}";
}
```

如果函式只有一行 `return`，可以改成箭頭函式。

```dart
int add(int a, int b) => a + b;
```

## 6. List 清單

Dart 的 `List<T>` 很像 C# 的 `List<T>`。

```dart
void main() {
  final names = ['Eric', 'Amy', 'Tom']; // List<String>

  print(names[0]);     // Eric
  print(names.length); // 3

  names.add('May');
  print(names);        // [Eric, Amy, Tom, May]
}
```

Dart 和 C# 一樣，index 從 `0` 開始。

### final List 仍可修改內容

```dart
void main() {
  final names = ['Eric', 'Amy'];

  names.add('Tom'); // 可以

  names = ['May']; // 錯誤：final 不能重新指定變數
}
```

`final` 限制的是變數不能指向另一個 List，不代表 List 裡面的內容不能變。如果內容也要固定，可以使用 `const`。

```dart
void main() {
  const names = ['Eric', 'Amy'];

  names.add('Tom'); // 錯誤
}
```

## 7. Map 字典

Dart 的 `Map<TKey, TValue>` 很像 C# 的 `Dictionary<TKey, TValue>`。

```dart
void main() {
  final scores = <String, int>{
    'Eric': 90,
    'Amy': 95,
  };

  scores['Tom'] = 88;

  print(scores['Eric']); // 90
}
```

`<String, int>` 代表：

```text
key 是 String
value 是 int
```

## 8. JSON 與 Map<String, dynamic>

API 回來的 JSON 可能長這樣：

```json
{
  "name": "Eric",
  "age": 18,
  "isStudent": true
}
```

在 Dart 裡常會先表示成：

```dart
final json = <String, dynamic>{
  'name': 'Eric',
  'age': 18,
  'isStudent': true,
};
```

`dynamic` 代表 value 可能是不同型別。

```text
name      -> String
age       -> int
isStudent -> bool
```

C# 類比上接近 `Dictionary<string, object>`，但 `dynamic` 更寬鬆，編譯器比較不會幫你檢查，所以通常會再轉成強型別 class。

## 9. class 類別

Dart class 可以用來描述資料結構。這在 Flutter API 串接中非常重要。

```dart
class User {
  const User({
    required this.name,
    required this.age,
  });

  final String name;
  final int age;
}
```

使用方式：

```dart
void main() {
  final user = User(
    name: 'Eric',
    age: 18,
  );

  print(user.name);
  print(user.age);
}
```

`required` 代表建立物件時一定要傳。這種 named arguments 在 Flutter Widget 裡非常常見。

## 10. factory fromJson：把 Map 轉成物件

API 資料通常不會直接拿來操作，而是會轉成強型別物件。

```dart
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.priceInCents,
  });

  final int id;
  final String name;
  final int priceInCents;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      priceInCents: json['priceInCents'] as int,
    );
  }
}
```

使用方式：

```dart
void main() {
  final json = <String, dynamic>{
    'id': 1,
    'name': 'Keyboard',
    'priceInCents': 199900,
  };

  final product = Product.fromJson(json);

  print(product.name); // Keyboard
}
```

`Product.fromJson(json)` 的意思是：

```text
把 JSON 解析後的 Map 資料，轉成 Product 物件。
```

實際 API 流程常長這樣：

```text
JSON 字串
  -> decode / dio 解析
  -> Map<String, dynamic>
  -> Product.fromJson(...)
  -> Product 物件
```

這個專案的 `Post.fromJson(json)` 也是同一個概念。

## 本章總結

- `var`、`final`、`const`
- `String`、`int`、`double`、`bool`
- `double` 會有浮點數精度問題，金額建議用整數最小單位
- `String?` 代表可能是 `null`
- `??`、`?.` 比 `!` 更安全
- function 可以有參數與回傳值
- `List<T>` 類似 C# `List<T>`
- `Map<TKey, TValue>` 類似 C# `Dictionary<TKey, TValue>`
- `Map<String, dynamic>` 常用來表示 JSON 解析後的資料
- class 可以建立強型別資料模型
- `fromJson` 負責把 Map 轉成 Dart 物件

## 練習題

1. 為什麼 `final name = 'Eric'; name = 'Amy';` 會錯？
2. Dart 的 `double` 適合做金額精準計算嗎？為什麼？
3. `String` 和 `String?` 差在哪裡？
4. `nickname ?? 'Guest'` 的意思是什麼？
5. `List<String>` 比較像 C# 的哪個型別？
6. `Map<String, dynamic>` 為什麼適合表示 JSON？
7. `Product.fromJson(json)` 主要解決什麼問題？
