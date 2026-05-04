# Flutter 常用 UI 元件庫 (UI Component Library)

本文件整理了開發 APP 時最常用的 UI 元件程式碼範本，你可以直接複製並修改使用。

## 1. 按鈕類 (Buttons)

```dart
// 1. 實心按鈕 (主要動作)
ElevatedButton(
  onPressed: () => print('Click'),
  child: Text('確認'),
)

// 2. 填滿按鈕 (Material 3 新增)
FilledButton(
  onPressed: () {},
  child: Text('提交'),
)

// 3. 外框按鈕 (次要動作)
OutlinedButton(
  onPressed: () {},
  child: Text('取消'),
)
```

## 2. 輸入類 (Inputs)

```dart
// 帶外框與圖示的輸入框
TextField(
  decoration: InputDecoration(
    labelText: '使用者名稱',
    hintText: '請輸入電子郵件',
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    prefixIcon: Icon(Icons.email),
  ),
)
```

## 3. 容器與卡片 (Containers & Cards)

```dart
// 精緻卡片佈局
Card(
  elevation: 5,
  child: Column(
    children: [
      Image.network('https://picsum.photos/200'),
      ListTile(
        title: Text('產品名稱'),
        subtitle: Text('$ 99.0'),
        trailing: Icon(Icons.shopping_cart),
      ),
    ],
  ),
)
```

## 4. 對話框與通知 (Dialogs & SnackBar)

```dart
// 顯示警告對話框
void showAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('提示'),
      content: Text('資料已成功儲存'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('確定')),
      ],
    ),
  );
}

// 顯示底部通知
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('已刪除項目'),
    action: SnackBarAction(label: '還原', onPressed: () {}),
  ),
);
```

## 5. 清單類 (Lists)

```dart
// 常用列表項
ListTile(
  leading: Icon(Icons.settings),
  title: Text('設定'),
  subtitle: Text('修改個人帳號資訊'),
  trailing: Icon(Icons.chevron_right),
  onTap: () {},
)
```

## 💡 UI 開發小撇步
- **間距處理**：推薦使用 `SizedBox(height: 16)` 而不是 `Padding` 來做簡單的垂直間距，代碼更簡潔。
- **點擊範圍**：對於自定義 UI，使用 `InkWell` 或 `GestureDetector` 包裹，並確保點擊範圍足夠大。
- **主題一致性**：盡量使用 `Theme.of(context).colorScheme.primary` 來取顏色，這樣換主題時 UI 會自動更新。
