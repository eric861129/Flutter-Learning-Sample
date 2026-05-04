# 範例索引

本文件列出目前專案中的範例、學習目標、入口檔案與測試位置。

## Dart Foundation

| 主題 | 入口 | 學習目標 |
| --- | --- | --- |
| 變數與空安全 | `dart_foundation/01_variables_null_safety.dart` | 了解 nullable type、`??`、`?.`、`final`、`const` |
| 集合 | `dart_foundation/02_collections.dart` | 了解 List、Set、Map、spread、`map`、`where` |
| 非同步 | `dart_foundation/03_async_programming.dart` | 了解 `Future`、`async` / `await`、`Stream` |
| 進階 OOP | `dart_foundation/04_oop_advanced.dart` | 了解 mixin、extension、sealed class、pattern matching |

對應教材：[Dart 基礎編程指南](lessons/DART_BASICS_GUIDE.md)

## Flutter UI

| 主題 | 入口 | 學習目標 |
| --- | --- | --- |
| 基礎 Widget | `lib/01_basic_widgets.dart` | Container、Row、Stack、Image |
| 狀態入門 | `lib/02_state_management.dart` | `StatelessWidget`、`StatefulWidget`、`setState` |
| Layout constraints | `lib/03_layout_principles.dart` | Constraints go down, sizes go up, parent sets position |
| Responsive layout | `lib/04_responsive_layout.dart` | `LayoutBuilder` 與寬窄版型 |
| UI Kit | `lib/views/ui_kit_view.dart` | 常用 Material 3 元件組合 |

對應教材：

- [Flutter UI 與元件指南](lessons/FLUTTER_UI_GUIDE.md)
- [Flutter 常用 UI 元件庫](lessons/UI_COMPONENT_LIBRARY.md)

## App Shell

| 主題 | 入口 | 學習目標 |
| --- | --- | --- |
| App bootstrap | `lib/main.dart` | `ProviderScope`、`MaterialApp.router` |
| 路由 | `lib/core/router.dart` | `go_router` routes |
| 主題 | `lib/core/theme.dart` | 亮色/深色主題與 Material 3 |
| 首頁 | `lib/views/home_page.dart` | 導覽頁如何串接範例 |

對應教材：

- [路由與導航指南](lessons/ROUTING_NAVIGATION_GUIDE.md)
- [主題與視覺設計指南](lessons/THEME_AND_STYLING_GUIDE.md)

## Feature Samples

| Feature | 入口 | 測試 | 學習目標 |
| --- | --- | --- | --- |
| Posts | `lib/features/posts/` | `test/features/posts/` | feature-first、Repository、ViewModel、AsyncValue、fake repository widget test |

對應教材：[進階狀態管理與網路串接](lessons/ADVANCED_STATE_NETWORK.md)
