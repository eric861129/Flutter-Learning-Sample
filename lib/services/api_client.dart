import 'package:dio/dio.dart';

/// 讀取 access token 的函式型別。
///
/// 用函式注入 token，而不是在 ApiClient 裡硬編碼，
/// 可以讓正式環境、測試環境與未登入狀態都更好切換。
typedef TokenReader = String? Function();

/// 專案共用 API client。
///
/// 預設連到 JSONPlaceholder；正式專案可透過建構子注入 baseUrl、Dio
/// 或 tokenReader，讓測試與環境切換更容易。
class ApiClient {
  ApiClient({
    Dio? client,
    String baseUrl = 'https://jsonplaceholder.typicode.com',
    TokenReader? tokenReader,
  }) {
    // 允許外部注入 Dio，測試時就能替換成假的 HTTP client。
    dio = client ?? Dio();

    // BaseOptions 是所有 request 共用的基本設定。
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: const {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // LogInterceptor 方便學習時觀察 request/response。
    // 真實產品可依環境決定是否開啟，避免 release log 太多。
    dio.interceptors.add(
      LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
      ),
    );

    // Interceptor 可以在每次 request 前統一補 headers。
    // 這裡示範 token 注入，但沒有 token 時不會送假 Authorization。
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = tokenReader?.call();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ),
    );
  }

  /// 對外暴露 Dio 實例，讓 feature 的 API service 可以發送 request。
  late final Dio dio;
}
