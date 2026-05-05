# 進階狀態管理與網路串接：深度指南 (Deep Dive into State & Network)

本指南將帶你進入較貼近實務的 Flutter 開發模式，結合 **Dio** 的高效請求與 **Riverpod** 的響應式狀態管理。

---

## 1. 專業級網路模組 - Dio 深度實戰

在真實專案中，我們不會只寫簡單的 GET 請求。我們需要處理 **Token 注入**、**日誌紀錄** 以及 **統一的錯誤處理**。

### A. 建立通用的 API 客戶端
```dart
import 'package:dio/dio.dart';

class ApiClient {
  late Dio _dio;

  ApiClient() {
    _dio = Dio(BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 5),
    ));

    // 添加攔截器 (Interceptors)
    _dio.interceptors.add(LogInterceptor(responseBody: true)); // 自動列印請求日誌
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // 在這裡注入 Token。沒有 token 時不要送假的 Authorization。
        final token = readToken();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        // 統一處理 401 或 500 錯誤
        if (e.response?.statusCode == 401) {
          print('Token 過期，請重新登入');
        }
        return handler.next(e);
      },
    ));
  }

  Dio get instance => _dio;
}
```

---

## 2. 響應式狀態管理 - Riverpod 核心模式

Riverpod 不只是「存數據」，它是為了處理「數據流」而生。

### A. 使用 `AsyncNotifier` 管理複雜狀態
當你的狀態需要異步獲取（如從網路拿列表），且允許手動更新（如刪除一項）時，這是最佳選擇。

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

// 定義一個狀態通知器
class PostNotifier extends AsyncNotifier<List<dynamic>> {
  @override
  Future<List<dynamic>> build() async {
    // 初始數據獲取
    return _fetchPosts();
  }

  Future<List<dynamic>> _fetchPosts() async {
    // 這裡調用你的 ApiService
    await Future.delayed(const Duration(seconds: 1));
    return [{'id': 1, 'title': 'Hello Riverpod'}];
  }

  // 手動新增資料的功能
  Future<void> addPost(Map<String, dynamic> post) async {
    state = const AsyncLoading(); // 顯示讀取中
    state = await AsyncValue.guard(() async {
      final currentPosts = state.value ?? [];
      return [...currentPosts, post]; // 更新本地列表
    });
  }
}

// 註冊 Provider
final postListProvider = AsyncNotifierProvider<PostNotifier, List<dynamic>>(PostNotifier.new);
```

---

## 3. UI 實戰：優雅處理異步數據

使用 `AsyncValue` 的 `when` 擴充方法，可以完美處理 UI 的三種狀態。

```dart
class PostListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. 監聽 Provider
    final postsAsync = ref.watch(postListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('進階數據列表')),
      body: postsAsync.when(
        // 數據成功回傳時
        data: (posts) => RefreshIndicator(
          onRefresh: () => ref.refresh(postListProvider.future),
          child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(posts[index]['title']),
            ),
          ),
        ),
        // 讀取中
        loading: () => const Center(child: CircularProgressIndicator()),
        // 出錯時
        error: (error, stack) => Center(
          child: Column(
            children: [
              Text('發生錯誤: $error'),
              ElevatedButton(
                onPressed: () => ref.invalidate(postListProvider), 
                child: const Text('重試'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## 🎯 為什麼這樣做？
1.  **自動緩存**：Riverpod 會自動記住數據，切換頁面不需要重新請求。
2.  **型別安全**：你不再需要檢查 `if (data != null)`，`when` 會強制你處理所有狀態。
3.  **可測試性**：你可以輕易地 Mock 一個 `ApiClient` 來進行測試。

## 4. 本專案的分層位置

本專案將文章列表拆成四層：

- `lib/services/api_client.dart`：共用 Dio 設定、timeout、headers、interceptors。
- `lib/features/posts/data/post_api_service.dart`：實際 HTTP request 與 JSON 轉換。
- `lib/features/posts/data/post_repository.dart`：資料入口，隔離 UI 與 service。
- `lib/features/posts/presentation/post_list_view_model.dart`：管理 UI state、刷新與本地刪除事件。
- `lib/features/posts/presentation/post_list_view.dart`：畫面呈現與事件轉交。

## 學完你應該能回答

- Dio、Repository、ViewModel、View 各自負責什麼？
- 為什麼 View 不應該直接呼叫 HTTP client？
- `AsyncValue.when` 如何強迫你處理 loading、data、error？
- fake repository 為什麼能讓 widget test 不依賴真實網路？

## 最小修改練習

1. 在 posts error UI 中調整錯誤文字，讓它更適合一般使用者閱讀。
2. 在 `PostListViewModel` 新增一個本地排序方法，例如依 title 排序。
3. 在 widget test 中補一個空列表情境，確認 UI 會顯示空狀態。

## 進階挑戰

1. 替 posts 加入 search/filter/pagination 的完整列表狀態。
2. 在 repository 加入簡單記憶體快取，避免重複呼叫 API。
3. 寫一篇 Blog，從 `PostListView` 往下追到 `ApiClient`，說明資料如何進到畫面。
