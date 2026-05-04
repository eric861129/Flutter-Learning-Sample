# 疑難排解

## `flutter` 不是可辨識的指令

這代表目前環境沒有 Flutter SDK，或 Flutter 不在 PATH 中。

本專案目前已知這台電腦無法安裝 Flutter，因此請改用 GitHub Actions 驗證。

## `dart` 不是可辨識的指令

這代表目前環境沒有 Dart SDK，或 Dart 不在 PATH 中。若不能安裝 SDK，純 Dart 範例也需要交給其他環境執行。

## `flutter analyze` 顯示 import 找不到

先檢查：

```bash
flutter pub get
```

再檢查文件或程式是否仍引用舊路徑：

```bash
rg -n "flutter_learning_sample/(models|repositories|view_models|services/api_service|views/post_list_view)" .
```

## Widget test 卡在 loading

常見原因是 async provider 還沒完成。測試中可以多呼叫一次：

```dart
await tester.pump();
await tester.pump();
```

若仍失敗，確認 fake repository 是否有回傳資料。

## 文件連結失效

新增、搬移或刪除檔案後，搜尋舊路徑：

```bash
rg -n "old_file_name|old_folder_name" .
```

文件是這個知識庫的一部分；路徑錯誤就等同範例壞掉。
