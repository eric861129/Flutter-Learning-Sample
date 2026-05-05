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
flutter test --coverage
```

測試完成後，CI 會把 `coverage/lcov.info` 上傳為 `flutter-coverage-lcov` artifact。
這份 coverage 報告用來檢查每個 feature 是否都有 repository、ViewModel、widget test 保護。

## 本機修改後的檢查清單

在推到 GitHub 前，至少做：

```bash
rg -n "TODO|TBD|MY_SECRET_TOKEN|colorScheme\.background" .
rg -n "flutter_learning_sample/(models|repositories|view_models|services/api_service|views/post_list_view)" .
git status --short
git diff --stat
```

這不能取代 `flutter analyze`，但能先抓掉很多文件與重構殘留問題。
