# Sample Catalog

本文件只回答「這個 repo 有哪些範例、在哪裡、測什麼」。如果你想先理解七天實作主題，請看 [project_brief.md](project_brief.md)。

## Catalog

| 類型 | Sample | 程式碼 | 測試 | 文件 | 學習重點 |
| --- | --- | --- | --- | --- | --- |
| Dart | Zero to One Syntax | `dart_foundation/01_variables_null_safety.dart`, `dart_foundation/02_collections.dart`, `lib/features/posts/domain/post.dart` | 無 | [Dart 零基礎語法筆記](lessons/DART_ZERO_TO_ONE_CSHARP.md) | C# 類比、變數、型別、null safety、List、Map、class、fromJson |
| Dart | Variables / Null Safety | `dart_foundation/01_variables_null_safety.dart` | 無 | [Dart 基礎](lessons/DART_BASICS_GUIDE.md) | nullable type、`??`、`?.`、`final`、`const` |
| Dart | Collections | `dart_foundation/02_collections.dart` | 無 | [Dart 基礎](lessons/DART_BASICS_GUIDE.md) | List、Set、Map、spread、`map`、`where` |
| Dart | Async | `dart_foundation/03_async_programming.dart` | 無 | [Dart 基礎](lessons/DART_BASICS_GUIDE.md) | `Future`、`async` / `await`、`Stream` |
| Dart | OOP Advanced | `dart_foundation/04_oop_advanced.dart` | 無 | [Dart 基礎](lessons/DART_BASICS_GUIDE.md) | mixin、extension、sealed class、pattern matching |
| UI | Widget Zero to One | `lib/views/home_page.dart`, `lib/01_basic_widgets.dart` | 無 | [Widget 零基礎筆記](lessons/WIDGET_ZERO_TO_ONE_CSHARP.md) | Widget tree、child/children、Scaffold、ListView、ListTile、onTap |
| UI | Basic Widgets | `lib/01_basic_widgets.dart` | `test/widget_test.dart` | [UI 指南](lessons/FLUTTER_UI_GUIDE.md) | Container、Row、Stack、Image |
| UI | State Intro | `lib/02_state_management.dart` | `test/unit_test.dart` | [Widget 心智模型](lessons/WIDGET_MENTAL_MODEL.md) | `StatelessWidget`、`StatefulWidget`、`setState` |
| UI | Layout Principles | `lib/03_layout_principles.dart` | 無 | [UI 指南](lessons/FLUTTER_UI_GUIDE.md) | constraints、size、position |
| UI | Responsive Layout | `lib/04_responsive_layout.dart` | 無 | [UI 指南](lessons/FLUTTER_UI_GUIDE.md) | `LayoutBuilder` 與寬窄版型 |
| UI | UI Kit | `lib/views/ui_kit_view.dart` | `test/widget_test.dart` | [UI Kit](lessons/UI_COMPONENT_LIBRARY.md) | 常用 Material 3 元件組合 |
| App Shell | Bootstrap / Router / Theme | `lib/main.dart`, `lib/app.dart`, `lib/core/router.dart`, `lib/core/theme.dart` | `integration_test/app_test.dart` | [架構總覽](architecture_overview.md) | `ProviderScope`、`MaterialApp.router`、`go_router`、ThemeData |
| Feature | Profile Form | `lib/features/profile_form/` | `test/features/profile_form/` | [profile form](features/profile_form.md) | `Form`、validator、submit loading、error display |
| Feature | Posts | `lib/features/posts/` | `test/features/posts/` | [posts](features/posts.md) | feature-first、Repository、ViewModel、AsyncValue、search、filter、pagination、fake repository |
| Feature | Settings | `lib/features/settings/` | `test/features/settings/` | [settings](features/settings.md) | SharedPreferences、ThemeMode、使用者偏好設定 |

## Feature-first 範例完整度

| Feature | Domain | Data | Presentation | Repository test | ViewModel test | Widget test | 文件 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Profile Form | 有 | 有 | 有 | 有 | 有 | 有 | 有 |
| Posts | 有 | 有 | 有 | 有 | 有 | 有 | 有 |
| Settings | 有 | 有 | 有 | 有 | 有 | 有 | 有 |

## 下一個適合補的 Sample

| 優先序 | Sample | 學習主題 | 建議原因 |
| --- | --- | --- | --- |
| 1 | Accessibility / localization | Semantics、字體縮放、l10n | 能提升官方 sample 成熟度 |
| 2 | Deployment / environment | flavor、app icon、splash、build command、CI artifact | 能補齊真實專案交付流程 |
| 3 | Golden / snapshot-style UI 深化 | golden test、穩定 UI 結構檢查 | 能補強官方 sample 的視覺回歸驗證 |
