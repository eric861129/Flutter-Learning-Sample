# 主題與視覺設計指南 (Theme & Styling)

讓 APP 看起來專業的關鍵在於「一致性」。永遠不要在 Widget 裡面寫死顏色（例如 `color: Colors.red`），而是使用 `ThemeData` 來全域管理。

## 1. 定義全域主題 (Material 3)

Flutter 目前全面支援 Material 3 設計語言，可以透過 `ColorScheme.fromSeed` 自動生成一整套和諧的色彩。

```dart
import 'package:flutter/material.dart';

class AppTheme {
  // 淺色主題
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueAccent,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );

  // 深色主題
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueAccent,
      brightness: Brightness.dark, // 產生深色色系
    ),
  );
}
```

## 2. 在專案中套用主題

在本專案中，`main.dart` 只負責啟動 app；真正設定 `theme` 與 `darkTheme` 的地方是 `lib/app.dart`。

```dart
MaterialApp(
  title: 'My App',
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  themeMode: ThemeMode.system, // 自動跟隨系統設定 (深色/淺色)
  home: const HomeScreen(),
);
```

## 3. 在 UI 中讀取主題顏色與字體

這是一致性的關鍵！使用 `Theme.of(context)` 來獲取顏色，這樣當用戶切換深色模式時，你的 UI 才會自動變色。

```dart
Widget build(BuildContext context) {
  // 取得當前主題
  final theme = Theme.of(context);

  return Container(
    // 使用表面色。新版 Flutter 建議使用 surface 取代 background。
    color: theme.colorScheme.surface,
    child: Text(
      '這是一段文字',
      // 使用標題字體與主要顏色
      style: theme.textTheme.headlineMedium?.copyWith(
        color: theme.colorScheme.primary,
      ),
    ),
  );
}
```

## 4. 響應式字體大小
盡量不要寫死 `fontSize: 16`。使用 `textTheme` (如 `bodyMedium`, `titleLarge`)，這可以確保當用戶在手機系統設定中放大字體時，你的 APP 也能完美適應，這是無障礙設計 (Accessibility) 的重要一環。

## 學完你應該能回答

- `ThemeData`、`ColorScheme`、`TextTheme` 各自負責什麼？
- 為什麼 Material 3 推薦用 `ColorScheme.fromSeed`？
- 為什麼 UI 應該用 `Theme.of(context)` 取色，而不是到處寫死 `Colors.blue`？
- 字體縮放為什麼和 accessibility 有關？

## 最小修改練習

1. 修改 `lib/core/theme.dart` 的 seed color，觀察整體色票如何變化。
2. 在 `SettingsView` 中確認文字樣式是否能從 theme 取得。
3. 找出一個寫死 `TextStyle(fontSize: ...)` 的地方，改成使用 `textTheme`。

## 進階挑戰

1. 替 app 新增一組更完整的 component theme，例如 `FilledButtonThemeData`。
2. 設計一份品牌色票，並說明 primary、secondary、surface 的用途。
3. 補一個大字體 widget test，確認主要頁面在字體放大時仍能 render。
