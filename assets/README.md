# Assets 規劃

這個資料夾預留給 Flutter app 的靜態資源，例如 app icon、splash image、示範圖片或字型。

目前專案還沒有正式資源檔，先用這份文件規劃命名方式，避免之後新增檔案時散亂。

## 建議命名

| 類型 | 建議路徑 | 用途 |
| --- | --- | --- |
| App icon 原始圖 | `assets/icons/app_icon.png` | 產生 Android / iOS app icon |
| Splash 圖片 | `assets/splash/splash_logo.png` | 產生啟動畫面 |
| 範例圖片 | `assets/images/sample_*.png` | 教學畫面或 UI sample |

## 教學重點

- App icon 和 splash 通常用套件產生，不建議手動改每個原生平台檔案。
- 真正加入資源後，要同步更新 `pubspec.yaml` 的 `flutter/assets` 設定。
- CI 或 build 文件應該說清楚哪些資源是必要輸入，哪些是可選素材。
