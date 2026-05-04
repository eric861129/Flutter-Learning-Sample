# CI 與開發環境

這台電腦目前因授權限制無法安裝 Flutter。因此本專案採用「本機靜態維護 + GitHub Actions 遠端驗證」的工作流。

## 本機可以做什麼

可以：

- 編輯 Dart / Flutter 原始碼
- 編輯 Markdown 文件
- 使用 `rg` 搜尋舊路徑、舊套件版本、文件不一致
- 檢查 Git diff

不能：

- 執行 `flutter pub get`
- 執行 `flutter analyze`
- 執行 `flutter test`
- 執行 `flutter run`

## GitHub Actions

CI 設定在：

```text
.github/workflows/flutter.yml
```

目前執行：

```bash
flutter pub get
flutter analyze
flutter test
```

## 本機修改後的檢查清單

在推到 GitHub 前，至少做：

```bash
rg -n "TODO|TBD|MY_SECRET_TOKEN|colorScheme\.background" .
rg -n "flutter_learning_sample/(models|repositories|view_models|services/api_service|views/post_list_view)" .
git status --short
git diff --stat
```

這不能取代 `flutter analyze`，但能先抓掉很多文件與重構殘留問題。
