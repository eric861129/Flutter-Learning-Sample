import 'package:dio/dio.dart';

import '../../../services/api_client.dart';
import '../domain/post.dart';

/// Posts feature 的遠端 API service。
///
/// 職責：
/// - 呼叫遠端 API。
/// - 處理 HTTP/Dio 相關錯誤。
/// - 把 raw JSON 轉成 [Post] domain model。
///
/// 注意：這一層不負責 UI 狀態，也不決定畫面如何顯示錯誤。
class PostApiService {
  /// 透過建構子注入 [ApiClient]，讓測試可以替換成 fake client。
  PostApiService({ApiClient? apiClient}) : _client = apiClient ?? ApiClient();

  final ApiClient _client;

  /// 從 JSONPlaceholder 取得文章列表。
  ///
  /// 回傳值已經是 `List<Post>`，因此 repository 和 ViewModel
  /// 不需要知道 API 原始 JSON 長什麼樣子。
  Future<List<Post>> getPosts() async {
    try {
      final response = await _client.dio.get<List<dynamic>>('/posts');
      if (response.statusCode == 200) {
        final data = response.data ?? <dynamic>[];
        // 只接受 Map<String, dynamic> 型別的項目，再逐一轉成 Post。
        // 這能避免 API 回傳非預期資料時直接污染 UI layer。
        return data
            .whereType<Map<String, dynamic>>()
            .map(Post.fromJson)
            .toList();
      }
      throw Exception('加載失敗');
    } on DioException catch (e) {
      // DioException 代表網路層或 HTTP request 發生問題。
      throw Exception('網路請求出錯: ${e.message}');
    } on Object catch (e) {
      // 其他例外也包成一致的錯誤訊息，交給 ViewModel/UI 呈現。
      throw Exception('網路請求出錯: $e');
    }
  }
}
