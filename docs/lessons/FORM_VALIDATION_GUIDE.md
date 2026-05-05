# 表單與驗證指南

表單是 Flutter app 最常見的互動場景之一。這一章聚焦五個主題：`Form`、`TextFormField`、`validator`、submit loading state、error display。

完整範例位於 [../features/profile_form.md](../features/profile_form.md)。

## 1. 為什麼需要 Form

`Form` 是多個欄位的驗證容器。它可以透過 `GlobalKey<FormState>` 一次觸發所有欄位的 validator。

```dart
final formKey = GlobalKey<FormState>();

Form(
  key: formKey,
  child: TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty) {
        return '請輸入內容';
      }
      return null;
    },
  ),
)
```

送出時：

```dart
if (formKey.currentState?.validate() != true) {
  return;
}
```

## 2. TextFormField 與 validator

`TextField` 適合單純輸入；`TextFormField` 適合需要表單驗證的欄位。

建議把 validator 抽成 helper：

```dart
class ProfileFormValidators {
  static String? email(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return '請輸入 Email';
    if (!text.contains('@')) return 'Email 格式不正確';
    return null;
  }
}
```

這樣 validator 可以被 unit test 保護，不需要靠手動點畫面確認。

## 3. Submit Loading State

表單送出通常是非同步流程。送出期間應該：

- 停用送出按鈕，避免重複送出。
- 顯示「送出中...」或 loading indicator。
- 成功或失敗後恢復按鈕狀態。

本專案用 `ProfileFormSubmissionState` 表示：

```text
idle
  -> submitting
  -> success / error
```

## 4. Error Display

錯誤不要只印在 console。使用者需要在畫面上看到：

- 發生什麼事
- 是否可以重試
- 哪些欄位需要修正

欄位錯誤用 validator 顯示；送出錯誤用頁面上的 error display 顯示。

## 5. 測試策略

表單至少應該測：

- validator unit test
- ViewModel submit success / error
- Widget test 驗證空表單錯誤
- Widget test 驗證 loading state
- Widget test 驗證 error display

## 學完你應該能回答

- `FormState.validate()` 會觸發什麼？
- validator 回傳 `null` 和回傳字串各代表什麼？
- 為什麼 submit loading state 應該被測試？
- 欄位錯誤和送出錯誤有什麼差別？

## 最小修改練習

1. 替 Profile Form 新增手機欄位。
2. 把 Email validator 改成更嚴格的格式檢查。
3. 補一個 widget test，確認送出失敗時會顯示錯誤區塊。

## 進階挑戰

1. 支援 server-side field error，例如 Email 已被註冊。
2. 把輸入欄位抽成共用 widget。
3. 替表單加上 accessibility labels 和大字體測試。
