# Flutter Learning Lab 專案簡介

這份文件定義本 repo 的實作主線。它回答：「七天後，我到底會完成一個什麼樣的 Flutter 專案？」

## 專案主題

**Flutter Learning Lab：用文章列表、表單與設定頁學會 Flutter App 架構。**

這不是商業產品模板，也不是只有單頁畫面的 demo。它是一個學習型 App，目標是讓初學者在七天內看懂並實作 Flutter 專案常見能力：

- Dart 語法與 null safety。
- Widget tree、Layout、Material 3 UI。
- 表單驗證與 submit state。
- API 串接、搜尋、篩選、分頁列表。
- 使用者偏好設定與本地儲存。
- Repository、ViewModel、fake repository 測試。
- CI 驗證與打包發布概念。

## 七天後會完成什麼

| 功能 | 對應程式碼 | 學到的能力 |
| --- | --- | --- |
| 首頁學習入口 | `lib/views/home_page.dart` | route、navigation、功能入口設計 |
| UI Kit | `lib/views/ui_kit_view.dart` | Material 3 元件與 layout |
| Profile Form | `lib/features/profile_form/` | `Form`、`TextFormField`、validator、loading、error display |
| Posts | `lib/features/posts/` | Dio、Repository、Riverpod、search、filter、pagination |
| Settings | `lib/features/settings/` | SharedPreferences、ThemeMode、使用者偏好 |
| Tests | `test/features/` | repository test、ViewModel test、widget test |
| CI | `.github/workflows/flutter.yml` | analyze、test、coverage artifact |

## 不做什麼

為了讓七天學習可完成，這個專案刻意不做：

- 完整會員登入與權限系統。
- 真實後端服務與資料庫。
- 複雜 Clean Architecture 分層。
- 商業產品級 UI 設計系統。
- App Store / Play Store 實際上架流程。

這些都可以是七天後的下一輪主題。第一週的重點是先建立 Flutter 專案的正確骨架。

## 教學架構

本專案採用簡化版 Clean Architecture / MVVM：

```text
View -> ViewModel -> Repository -> Service / API / Storage
```

每一層的白話說法：

- **View**：畫面。負責顯示資料、接收點擊或輸入。
- **ViewModel**：畫面的腦袋。負責把使用者動作轉成狀態變化。
- **Repository**：資料入口。負責決定資料從 API、本地儲存或 fake 來源而來。
- **Service**：真正跟外部世界互動，例如 HTTP 或 SharedPreferences。

## Day 1 的開始方式

Day 1 從「環境建立與 Dart 語法精要」開始。

如果你的電腦可以安裝 Flutter，Day 1 會先確認：

```bash
flutter --version
flutter doctor
flutter pub get
```

如果你的電腦無法安裝 Flutter，就改用本 repo 的限制版流程：

1. 本機閱讀 `docs/`、`lib/`、`test/`。
2. 透過 GitHub Actions 執行 `flutter analyze` 與 `flutter test --coverage`。
3. 把本機無法驗證的部分記錄在 `PROJECT_STATUS.md`。

這兩條路都能學，只是驗證位置不同。
