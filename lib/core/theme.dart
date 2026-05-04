import 'package:flutter/material.dart';

/// 示範專案全域主題配置。
///
/// ThemeData 適合放在 `core/`，因為它是整個 app 共用的視覺規則。
/// 這裡示範 Material 3 的 `ColorScheme.fromSeed`，用一個種子色產生完整色票。
class AppTheme {
  /// 亮色主題。
  ///
  /// 教學重點：盡量讓元件從 Theme 取顏色，而不是到處寫死 `Colors.xxx`。
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6200EE), // 主題種子色。
      brightness: Brightness.light,
    ),
    // AppBar 的共同外觀集中設定，頁面就不需要重複指定。
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
    ),
    // 表單輸入框的共同樣式。
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
      fillColor: Colors.grey[100],
    ),
  );

  /// 深色主題。
  ///
  /// 這裡使用同一個 seed color，但指定 `Brightness.dark`，
  /// Flutter 會產生適合深色模式的 Material 3 色彩。
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6200EE),
      brightness: Brightness.dark,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
    ),
  );
}
