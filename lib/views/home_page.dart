import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../02_state_management.dart';

/// 學習範例首頁。
///
/// 這個頁面是 app 的目錄，負責把各個獨立範例串起來。
/// 真正的範例內容不寫在這裡，避免首頁同時承擔太多職責。
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter 學習路徑')),
      body: ListView(
        // 底部留白避免最後一個項目太貼近螢幕邊緣。
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          _buildSection(
            context,
            title: '基礎 UI',
            items: const [
              _LearningItem('01 基礎元件', '/basic-widgets'),
              _LearningItem('03 佈局原理', '/layout'),
              _LearningItem('04 響應式佈局', '/responsive'),
              _LearningItem('UI 元件庫', '/ui-kit'),
              _LearningItem('Form 表單驗證', '/profile-form'),
            ],
          ),
          _buildSection(
            context,
            title: '狀態與資料',
            items: const [
              _LearningItem('Riverpod + Dio 文章列表', '/posts'),
              _LearningItem('SharedPreferences 偏好設定', '/settings'),
            ],
            header: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CounterWidget(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<_LearningItem> items,
    Widget? header,
  }) {
    // 從 Theme 取得色彩與文字樣式，讓亮色/深色主題能一致套用。
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (header != null) header,
        for (final item in items)
          ListTile(
            title: Text(item.title),
            trailing: const Icon(Icons.chevron_right),
            // 使用 go_router 的 context.push 進行頁面切換。
            onTap: () => context.push(item.path),
          ),
        const Divider(),
      ],
    );
  }
}

/// 首頁清單中的單一學習項目。
///
/// 使用小型資料類別可以避免 `_buildSection` 傳入多個平行 list，
/// 也讓每個項目的標題與路徑綁在一起。
class _LearningItem {
  const _LearningItem(this.title, this.path);

  final String title;
  final String path;
}
