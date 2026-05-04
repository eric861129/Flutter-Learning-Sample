import 'package:flutter/material.dart';

/// 完整 UI 元件庫範例 (UI Kit Gallery)
/// 此頁面彙整了開發 APP 時最常使用的各類元件。
class UIKitView extends StatelessWidget {
  const UIKitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter 元件庫')),
      body: ListView(
        // UI kit 通常用捲動清單呈現，方便持續新增元件區塊。
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle('1. 各式按鈕 (Buttons)'),
          // Wrap 會在水平空間不足時自動換行，比 Row 更適合按鈕集合。
          Wrap(
            spacing: 8,
            children: [
              ElevatedButton(onPressed: () {}, child: const Text('實心按鈕')),
              FilledButton(onPressed: () {}, child: const Text('填滿按鈕')),
              OutlinedButton(onPressed: () {}, child: const Text('外框按鈕')),
              TextButton(onPressed: () {}, child: const Text('文字按鈕')),
              IconButton(onPressed: () {}, icon: const Icon(Icons.add_a_photo)),
            ],
          ),
          const Divider(),

          _sectionTitle('2. 表單與輸入 (Inputs)'),
          // TextField 是最常見的文字輸入元件。
          const TextField(
            decoration: InputDecoration(
              labelText: '標準輸入框',
              hintText: '請輸入內容...',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 16),
          // 密碼欄位通常會設定 obscureText，並搭配顯示/隱藏圖示。
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: '密碼輸入框',
              border: const UnderlineInputBorder(),
              suffixIcon: IconButton(onPressed: () {}, icon: const Icon(Icons.visibility)),
            ),
          ),
          const Divider(),

          _sectionTitle('3. 選取與開關 (Selection)'),
          // Checkbox、Switch、Slider 都屬於使用者可直接操作的表單元件。
          Row(
            children: [
              Checkbox(value: true, onChanged: (v) {}),
              const Text('勾選框'),
              const Spacer(),
              Switch(value: true, onChanged: (v) {}),
              const Text('切換開關'),
            ],
          ),
          Slider(value: 0.5, onChanged: (v) {}),
          const Divider(),

          _sectionTitle('4. 卡片與容器 (Cards)'),
          // Card 適合呈現一組有邊界的資訊，例如產品、文章、個人資料。
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: const Icon(Icons.image, size: 50, color: Colors.white),
                ),
                const ListTile(
                  title: Text('精緻卡片標題'),
                  subtitle: Text('這是一個帶有圓角、陰影與頂部圖片的卡片範例。'),
                ),
              ],
            ),
          ),
          const Divider(),

          _sectionTitle('5. 彈窗與反饋 (Feedback)'),
          // Dialog 適合需要使用者確認的情境；SnackBar 適合短暫提示。
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _showDialog(context),
                child: const Text('顯示對話框'),
              ),
              ElevatedButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('這是一個通知 (SnackBar)')),
                ),
                child: const Text('顯示通知'),
              ),
            ],
          ),
          const Divider(),

          _sectionTitle('6. 列表項目 (List Items)'),
          // ListTile 是設定頁、清單頁中最常用的標準列項。
          const ListTile(
            leading: CircleAvatar(child: Text('A')),
            title: Text('標準列表項目'),
            subtitle: Text('帶有圖示、標題與副標題'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
          const Divider(),

          _sectionTitle('7. 進度條 (Progress)'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: LinearProgressIndicator(value: 0.7),
          ),
          const Center(child: CircularProgressIndicator()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    // 將段落標題抽成 helper，讓 UI kit 的每個區塊風格一致。
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    // showDialog 會在目前頁面上方開啟 modal。
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('系統確認'),
        content: const Text('您確定要執行此操作嗎？'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('取消')),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('確定')),
        ],
      ),
    );
  }
}
