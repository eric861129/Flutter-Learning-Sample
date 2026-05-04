/// Posts feature 使用的文章 Domain Model。
///
/// Domain model 是 app 內部真正想操作的資料形狀。
/// 這一層不要讓 `Map<String, dynamic>` 直接流到 UI，
/// 否則畫面會到處依賴 API 欄位名稱，日後很難維護。
class Post {
  const Post({
    required this.id,
    required this.title,
    required this.body,
  });

  final int id;
  final String title;
  final String body;

  /// 將 API 回傳的 JSON 轉成強型別的 [Post]。
  ///
  /// 教學重點：
  /// - JSON 解析集中在 model/data layer。
  /// - 使用 `as int`、`as String` 明確轉型，避免 dynamic 擴散。
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}
