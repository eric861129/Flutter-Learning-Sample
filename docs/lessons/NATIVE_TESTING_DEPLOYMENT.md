# 原生功能、測試與上架完全指南 (The Complete Guide for Beginners)

本指南專為 Flutter 初學者設計，帶你了解如何突破 Flutter 框架限制、確保程式品質，並最終將 APP 送上商店。

---

## 1. 突破限制：原生功能調用 (Method Channels)

### 為什麼需要它？
雖然 Flutter 提供了豐富的套件，但有時你需要的功能太新或太冷門（例如：特定的硬體傳感器、特定的系統 API）。這時就需要透過 **MethodChannel** 與原生（Android 的 Kotlin, iOS 的 Swift）通訊。

### 運作原理：就像打電話
1. **Flutter 端**：撥號（呼叫方法名）。
2. **原生端**：接聽（執行代碼並回傳結果）。

### 實戰範例：獲取裝置電池電量
```dart
import 'package:flutter/services.dart';

class BatteryService {
  // 1. 定義頻道，名稱必須唯一 (通常用反向域名)
  static const platform = MethodChannel('samples.flutter.dev/battery');

  Future<void> getBatteryLevel() async {
    try {
      // 2. 呼叫原生端的方法 'getBatteryLevel'
      final int result = await platform.invokeMethod('getBatteryLevel');
      print('電池電量: $result%');
    } on PlatformException catch (e) {
      print("獲取失敗: '${e.message}'.");
    }
  }
}
```

---

## 2. 品質保證：三種自動化測試

在 Flutter 中，測試分為三個層級，就像檢查一台車：

### A. 單元測試 (Unit Test) - 檢查零件
測試獨立的函數或類別邏輯。
* **位置**：`test/` 目錄。
* **範例**：測試一個簡單的加法器。
```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('驗證加法邏輯', () {
    final result = 1 + 1;
    expect(result, 2); // 預期結果應等於 2
  });
}
```

### B. 元件測試 (Widget Test) - 檢查面板
測試單個元件的 UI 與互動（不需要跑真機）。
```dart
testWidgets('測試按鈕點擊後文字是否改變', (WidgetTester tester) async {
  // 1. 載入 Widget
  await tester.pumpWidget(const MyButtonApp());

  // 2. 點擊按鈕
  await tester.tap(find.byType(ElevatedButton));

  // 3. 讓畫面重新渲染
  await tester.pump();

  // 4. 驗證文字是否變成 '已點擊'
  expect(find.text('已點擊'), findsOneWidget);
});
```

### C. 整合測試 (Integration Test) - 試駕
在真機上模擬真人操作，跑過所有流程。
* **套件**：使用 `integration_test`。

---

## 3. 完美變身：上架前的視覺配置

### A. 更換 APP 圖示 (App Icon)
不要手動去改原生目錄！使用 `flutter_launcher_icons` 套件：
1. 在 `pubspec.yaml` 配置圖片路徑。
2. 執行：`flutter pub run flutter_launcher_icons:main`。

### B. 製作啟動畫面 (Splash Screen)
使用 `flutter_native_splash`：
1. 定義背景顏色與 LOGO 圖片。
2. 執行指令自動生成原生 iOS/Android 的啟動檔。

---

## 4. 最後一哩路：上架商店流程

### 🚀 Android (Google Play)
1. **建立金鑰 (Keystore)**：這是應用的「身分證」，丟了就無法更新 APP。
2. **配置 `key.properties`**：告訴 Flutter 打包時去哪裡找金鑰。
3. **執行打包**：
   ```bash
   flutter build appbundle --release
   ```
   這會生成 `.aab` 檔案，上傳至 Google Play Console。

### 🍎 iOS (App Store)
1. **申請開發者帳號**：年費 $99 USD。
2. **Xcode 設定**：設定 `App ID`, `Provisioning Profile`。
3. **執行打包**：
   ```bash
   flutter build ipa
   ```
4. **上傳**：使用 Apple 的 **Transporter** 工具將 `.ipa` 上傳至 App Store Connect。

---

## 💡 給小白的真心建議
1. **先求有再求好**：初學者建議先從 **Unit Test** 寫起，這對邏輯思考很有幫助。
2. **多用現成套件**：在上架配置（Icon/Splash）上，盡量使用社群套件，避免手動修改原生代碼導致出錯。
3. **檢查清單**：上架前一定要在「真機」上跑過，不要只依賴模擬器。
