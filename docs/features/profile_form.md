# Profile Form Feature Walkthrough

Profile Form 是本專案的表單與驗證範例。它示範如何用 `Form`、`TextFormField`、`validator` 建立可驗證表單，並用 ViewModel 管理 submit loading state 與 error display。

## 學習目標

讀完這個 feature 後，你應該能回答：

- `Form` 和 `TextFormField` 如何合作？
- validator 應該寫在 Widget 裡，還是抽成可測試的 helper？
- submit loading state 為什麼不應該只靠按鈕文字硬切？
- 送出失敗時，錯誤訊息應該如何顯示給使用者？
- Widget test 如何驗證表單錯誤與 submit 狀態？

## 檔案地圖

```text
lib/features/profile_form/
  domain/
    profile_form_data.dart
  data/
    profile_form_repository.dart
  presentation/
    profile_form_validators.dart
    profile_form_view_model.dart
    profile_form_view.dart
```

測試：

```text
test/features/profile_form/
  data/profile_form_repository_test.dart
  presentation/profile_form_validators_test.dart
  presentation/profile_form_view_model_test.dart
  presentation/profile_form_view_test.dart
```

## Domain

`profile_form_data.dart` 定義表單送出時整理好的資料。

UI 中的 `TextEditingController` 不應直接流到資料層。送出前先把 controller 的文字整理成 `ProfileFormData`，ViewModel 和 Repository 就能依賴明確型別。

## Data Layer

`profile_form_repository.dart` 定義 `ProfileFormRepository` 抽象與 demo 實作。

```text
ProfileFormView
  -> ProfileFormViewModel
  -> ProfileFormRepository
```

雖然目前只是 demo submit，仍保留 repository 介面，是為了示範真實 app 常見的表單送出分層。

## Presentation Layer

`profile_form_validators.dart` 集中管理欄位驗證：

- 姓名必填
- Email 必填與基本格式
- 密碼必填與至少 8 碼

`profile_form_view_model.dart` 管理 submit state：

- `isSubmitting`
- `isSuccess`
- `errorMessage`

`profile_form_view.dart` 負責：

- 建立 `Form`
- 綁定 `TextEditingController`
- 呼叫 `FormState.validate()`
- 送出成功顯示 SnackBar
- 送出失敗顯示錯誤區塊

## 測試設計

Validator test：

- 驗證空姓名
- 驗證 Email 格式
- 驗證密碼長度

Repository test：

- 驗證 demo repository 能完成送出流程

ViewModel test：

- 成功送出後進入 success state
- repository 失敗時顯示 error state

Widget test：

- 空表單送出時顯示 validator 訊息
- 有效表單送出時顯示 loading state
- 送出失敗時顯示 error display

## 學完你應該能回答

- `TextField` 和 `TextFormField` 的差別是什麼？
- `GlobalKey<FormState>` 在表單驗證中扮演什麼角色？
- 為什麼 submit loading state 要放進 ViewModel？
- 為什麼錯誤訊息要顯示在 UI，而不是只印在 console？

## 最小修改練習

1. 新增一個手機欄位，並驗證至少 10 碼。
2. 替個人簡介新增最多 120 字的 validator。
3. 在 widget test 補上手機欄位驗證情境。

## 進階挑戰

1. 把表單送出接到真正 API。
2. 新增 server-side field error，例如 Email 已被使用。
3. 把表單拆成可重用的 input component，並補 snapshot-style widget test。
