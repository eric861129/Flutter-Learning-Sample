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
