import 'post.dart';

/// Posts 列表可以使用的搜尋範圍。
///
/// 教學重點：
/// - enum 適合表達「固定幾種選項」。
/// - UI、ViewModel、Repository 共用同一個 enum，可以避免用字串傳來傳去。
enum PostSearchFilter {
  all,
  title,
  body,
}

/// Posts 列表查詢條件。
///
/// 這個 value object 把搜尋文字、篩選範圍與分頁資訊集中起來，
/// Repository 就不需要接收一長串零散參數。
class PostQuery {
  const PostQuery({
    this.searchTerm = '',
    this.filter = PostSearchFilter.all,
    this.page = 1,
    this.pageSize = 10,
  });

  final String searchTerm;
  final PostSearchFilter filter;
  final int page;
  final int pageSize;

  PostQuery copyWith({
    String? searchTerm,
    PostSearchFilter? filter,
    int? page,
    int? pageSize,
  }) {
    return PostQuery(
      searchTerm: searchTerm ?? this.searchTerm,
      filter: filter ?? this.filter,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

/// Repository 回傳給 ViewModel 的分頁結果。
///
/// [items] 是當頁資料；[hasMore] 告訴 UI 是否還能繼續載入下一頁。
class PostPage {
  const PostPage({
    required this.items,
    required this.hasMore,
  });

  final List<Post> items;
  final bool hasMore;
}
