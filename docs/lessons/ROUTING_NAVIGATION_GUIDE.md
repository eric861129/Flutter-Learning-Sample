# 路由與導航指南 (Routing & Navigation)

專業的 Flutter APP 通常不會只依賴零散的 `Navigator.push`，而會使用宣告式路由套件，例如 **`go_router`**。它適合處理深層連結、網址列同步、命名路由與複雜頁面流程。

## 1. 為什麼要用 `go_router`？
- **網址列同步**：在 Flutter Web 中，網址會自動隨著頁面變化。
- **深層連結**：從外部點擊連結 (如 `myapp://user/123`) 可以直接跳轉到特定頁面。
- **重定向 (Redirection)**：例如，如果用戶未登入，嘗試進入設定頁面時，會自動跳轉到登入頁面。

## 2. `go_router` 基礎配置範例

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 1. 定義路由設定
final GoRouter myRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/details/:id', // 帶參數的路由
      builder: (context, state) {
        // 取出參數
        final id = state.pathParameters['id'];
        return DetailScreen(id: id!);
      },
    ),
  ],
);

// 2. 在 MaterialApp 中使用
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: myRouter,
    );
  }
}
```

本專案的實作位於 `lib/core/router.dart`，首頁透過 `MaterialApp.router` 掛上 `appRouter`。

## 3. 如何跳轉頁面？

```dart
// 替換當前頁面 (常用於底導航欄切換)
context.go('/details/123');

// 疊加頁面 (會出現返回鍵)
context.push('/details/123');

// 返回上一頁
if (context.canPop()) {
  context.pop();
}
```

## 4. 進階：守衛與重定向 (Auth Guard)

這在處理「需要登入才能訪問的頁面」時非常有用：

```dart
final router = GoRouter(
  redirect: (context, state) {
    final isLoggedIn = checkLoginState(); // 假設這是一個檢查登入狀態的函數
    final isGoingToLogin = state.uri.toString() == '/login';

    // 如果未登入，且想去非登入頁面 -> 強制去登入頁
    if (!isLoggedIn && !isGoingToLogin) return '/login';
    
    // 如果已登入，且想去登入頁 -> 強制回首頁
    if (isLoggedIn && isGoingToLogin) return '/';

    return null; // 不需要重定向
  },
  // ... routes
);
```

## 學完你應該能回答

- `go_router` 和直接使用 `Navigator.push` 的差別是什麼？
- 為什麼路由表適合集中放在 `core/router.dart`？
- `context.push`、`context.go`、`context.pop` 各代表什麼意圖？
- redirect / auth guard 適合處理哪些流程？

## 最小修改練習

1. 在 `lib/core/router.dart` 新增一個簡單的 demo route。
2. 在 `HomePage` 加入對應的學習項目入口。
3. 替新增 route 寫一個最小 widget test，確認頁面標題存在。

## 進階挑戰

1. 替 posts 新增 detail route，點擊文章後進入詳細頁。
2. 設計一個假登入狀態，練習用 redirect 保護 `/settings`。
3. 寫一篇筆記，比較 declarative routing 和 imperative navigation 的心智模型。
