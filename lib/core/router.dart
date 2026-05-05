import 'package:go_router/go_router.dart';

import '../01_basic_widgets.dart';
import '../03_layout_principles.dart';
import '../04_responsive_layout.dart';
import '../features/posts/presentation/post_list_view.dart';
import '../features/profile_form/presentation/profile_form_view.dart';
import '../features/settings/presentation/settings_view.dart';
import '../views/home_page.dart';
import '../views/ui_kit_view.dart';

/// App 的集中式路由表。
///
/// 教學重點：
/// - 使用 `go_router` 可以讓頁面路徑集中管理。
/// - Flutter Web 或 deep link 場景會比手寫 `Navigator.push` 更容易維護。
/// - 每個 `GoRoute` 都對應一個可進入的學習範例頁。
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // 首頁：作為所有學習範例的導覽入口。
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    // 基礎 Widget 範例。
    GoRoute(
      path: '/basic-widgets',
      builder: (context, state) => const BasicWidgetsDemo(),
    ),
    // Layout constraint 範例。
    GoRoute(
      path: '/layout',
      builder: (context, state) => const LayoutPrinciplesDemo(),
    ),
    // 響應式版面範例。
    GoRoute(
      path: '/responsive',
      builder: (context, state) => const ResponsiveDemo(),
    ),
    // 常用 UI 元件展示。
    GoRoute(
      path: '/ui-kit',
      builder: (context, state) => const UIKitView(),
    ),
    // 表單、驗證與送出狀態範例。
    GoRoute(
      path: '/profile-form',
      builder: (context, state) => const ProfileFormView(),
    ),
    // 完整 feature-first + MVVM 範例。
    GoRoute(
      path: '/posts',
      builder: (context, state) => const PostListView(),
    ),
    // 使用者偏好設定範例。
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsView(),
    ),
  ],
);
