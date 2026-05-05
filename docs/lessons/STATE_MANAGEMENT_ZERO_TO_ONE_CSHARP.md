# Flutter 狀態管理零基礎筆記：給 C# 開發者的第一輪複習

這份筆記整理從 Widget 進入狀態管理時最重要的觀念。目標不是一次學完 Riverpod，而是先能判斷狀態該放在哪裡，並看懂專案中的 Settings 資料流。

## 這份筆記在專案中的位置

建議閱讀順序：

```text
docs/lessons/WIDGET_ZERO_TO_ONE_CSHARP.md
  -> lib/02_state_management.dart
  -> docs/lessons/STATE_MANAGEMENT_ZERO_TO_ONE_CSHARP.md
  -> lib/features/settings/
  -> docs/features/settings.md
  -> docs/lessons/ADVANCED_STATE_NETWORK.md
```

對照專案檔案：

| 你正在學的概念 | 專案中的對照位置 |
| --- | --- |
| `StatefulWidget`、`setState`、局部 UI 狀態 | `lib/02_state_management.dart` |
| App 層級主題設定 | `lib/app.dart` |
| 使用者偏好 model、`copyWith`、theme mode | `lib/features/settings/domain/user_preferences.dart` |
| ViewModel 狀態與流程 | `lib/features/settings/presentation/settings_view_model.dart` |
| Repository 讀寫資料 | `lib/features/settings/data/settings_repository.dart` |
| Settings UI 與 Riverpod `ref` | `lib/features/settings/presentation/settings_view.dart` |

## 1. 狀態要放哪裡

Flutter 初學最常遇到的問題是：

```text
這個狀態應該放在 StatelessWidget？
StatefulWidget？
還是 ViewModel / Riverpod？
```

先用這張表判斷：

| 情境 | 適合放哪裡 | 例子 |
| --- | --- | --- |
| 完全沒有可變狀態 | `StatelessWidget` | 固定標題、單純顯示資料 |
| 只屬於單一 Widget 的短期 UI 狀態 | `StatefulWidget + setState` | counter、展開/收合、目前 tab index |
| 多個 Widget / 多頁都要用 | ViewModel / Riverpod | App theme、登入者資料、購物車 |
| 來自 API 或本地儲存 | Repository + ViewModel | posts、settings、user profile |
| 需要 loading / error / data | ViewModel / Riverpod | 文章列表、表單送出、設定載入 |

簡化判斷：

```text
StatelessWidget
  = 我只顯示資料，不自己改。

StatefulWidget
  = 我自己有小狀態，自己改自己重畫。

ViewModel / Riverpod
  = 資料很重要，很多地方要用，還可能牽涉 API、儲存、測試。
```

## 2. StatelessWidget

`StatelessWidget` 適合：

```text
自己不保存會變動的狀態
只根據外部資料或固定內容回傳 Widget tree
```

例如：

```dart
class UserNameText extends StatelessWidget {
  const UserNameText({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(name);
  }
}
```

這個 Widget 只承接 `name` 並顯示，不自己修改，所以適合 `StatelessWidget`。

專案中的 `HomePage` 也是 `StatelessWidget`，因為它只是顯示固定學習選單，自己不保存可變狀態。

## 3. StatefulWidget 與 State

`StatefulWidget` 適合保存：

```text
局部
短期
只屬於這個 Widget 的 UI 狀態
```

例如：

```text
CounterWidget 的 count
某張卡片是否展開
目前選到哪個 tab
某個輸入框的暫時內容
動畫 controller
```

典型結構：

```dart
class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Text('目前計數：$_count');
  }
}
```

分工：

```text
CounterWidget
  -> 宣告這是一個 StatefulWidget
  -> createState() 建立對應 State

_CounterWidgetState
  -> 保存 _count
  -> build() 根據 _count 建立畫面
  -> setState() 修改 _count 並觸發更新
```

`_CounterWidgetState` 前面的 `_` 表示 library-private，可以先理解成目前檔案內部使用。

## 4. setState

`setState` 的主要責任：

```text
修改狀態
通知 Flutter 重新 build
```

範例：

```dart
ElevatedButton(
  onPressed: () {
    setState(() {
      _count++;
    });
  },
  child: const Text('增加'),
)
```

流程：

```text
使用者按下按鈕
  -> onPressed 被呼叫
  -> setState 執行
  -> _count++
  -> Flutter 重新 build
  -> Text 顯示新數字
```

如果只寫：

```dart
_count++;
```

資料可能有變，但 Flutter 不一定知道要更新畫面。  
所以會影響 UI 的狀態改變，通常要放在 `setState` 裡。

## 5. 事件函式不要立刻執行

Flutter 事件需要的是「之後才執行的函式」。

可以：

```dart
onPressed: _increment
```

也可以：

```dart
onPressed: () => _increment()
```

如果寫成：

```dart
onPressed: _increment()
```

代表現在立刻呼叫 `_increment()`，不是等點擊時才執行。

同理：

```dart
onTap: () => context.push('/posts')
```

是等點擊時才導航。

```dart
onTap: context.push('/posts')
```

則是現在就呼叫，不是正確的事件處理器寫法。

## 6. build() 的責任

`build()` 的主要責任：

```text
根據目前資料，回傳 Widget tree。
```

適合放在 `build()` 裡：

```text
回傳 Text('Hello')
根據 _count 顯示文字
根據 state 決定要顯示哪個 Widget
```

不適合直接放在 `build()` 裡：

```text
呼叫 API
寫入資料庫
啟動 timer
大量昂貴計算
改變 state
```

因為 `build()` 可能會執行很多次。Flutter 的思維是：

```text
不要手動操作畫面元件
而是改變 state
讓 build 根據 state 重新描述畫面
```

## 7. 什麼時候升級到 ViewModel / Riverpod

如果狀態只是這個 Widget 自己的小狀態，`StatefulWidget + setState` 通常就夠。

例如：

```text
某一張 FAQ 卡片目前展開或收合
```

適合：

```text
StatefulWidget + setState
```

但如果狀態牽涉到：

```text
跨頁共享
API 查詢
本地儲存
loading / error / data
需要測試
多個 Widget 都會使用
```

就應該考慮 ViewModel / Riverpod。

例如：

```text
App 目前使用亮色模式或深色模式，而且所有頁面都要跟著變
```

適合：

```text
ViewModel / Riverpod
```

## 8. Settings 狀態為什麼不放 StatefulWidget

深色模式是整個 App 的狀態，不是單一 Widget 的狀態。

它通常需要：

```text
跨頁共享
影響整個 App
保存到本地儲存
App 重開後仍然記得
很多 Widget 都能讀到
```

所以在這個專案裡，Settings 使用：

```text
SettingsView
  -> SettingsViewModel
  -> SettingsRepository
  -> StorageService / SharedPreferences
```

`app.dart` 讀取目前設定：

```dart
final preferences = ref.watch(settingsViewModelProvider).valueOrNull ??
    const UserPreferences();

return MaterialApp.router(
  themeMode: preferences.themeMode.toThemeMode(),
  // ...
);
```

意思是：

```text
MyApp 從 SettingsViewModel 讀目前偏好設定
把 preferences.themeMode 轉成 Flutter ThemeMode
交給 MaterialApp 套用到整個 App
```

## 9. UserPreferences 與 immutable model

`UserPreferences` 可以先理解成使用者偏好設定資料模型。

概念像：

```dart
class UserPreferences {
  const UserPreferences({
    this.themeMode = AppThemeMode.system,
  });

  final AppThemeMode themeMode;
}
```

`final` 欄位代表建立後不能直接修改。

所以不是：

```dart
preferences.themeMode = AppThemeMode.dark; // 不行
```

而是建立新物件：

```dart
final next = preferences.copyWith(
  themeMode: AppThemeMode.dark,
);
```

C# 類比：

```csharp
var next = preferences with
{
    ThemeMode = AppThemeMode.Dark
};
```

## 10. copyWith

`copyWith` 的用途：

```text
從舊物件複製一份新物件，並只覆蓋你指定要改的欄位。
```

例如：

```dart
final next = preferences.copyWith(
  themeMode: AppThemeMode.dark,
);
```

意思是：

```text
其他設定沿用 preferences
只有 themeMode 改成 dark
```

這種 immutable model 對 UI rebuild、測試、除錯都更清楚。

## 11. AppThemeMode 與 ThemeMode

專案可能會定義自己的 enum：

```dart
enum AppThemeMode {
  system,
  light,
  dark,
}
```

C# 類比：

```csharp
enum AppThemeMode
{
    System,
    Light,
    Dark
}
```

Flutter 內建的 `MaterialApp` 要吃的是：

```dart
ThemeMode.system
ThemeMode.light
ThemeMode.dark
```

所以會有轉換方法，概念像：

```dart
extension AppThemeModeX on AppThemeMode {
  ThemeMode toThemeMode() {
    return switch (this) {
      AppThemeMode.system => ThemeMode.system,
      AppThemeMode.light => ThemeMode.light,
      AppThemeMode.dark => ThemeMode.dark,
    };
  }
}
```

這行：

```dart
themeMode: preferences.themeMode.toThemeMode()
```

意思是：

```text
把 preferences 裡的 themeMode，轉成 Flutter MaterialApp 能使用的 ThemeMode。
```

## 12. ViewModel

ViewModel 的角色：

```text
負責狀態與流程。
```

更完整一點：

```text
ViewModel 是 View 和 Repository 之間的協調者，
負責保存 UI 需要的狀態，並處理使用者操作後要走的流程。
```

在 settings feature 裡：

```text
使用者切換主題
  -> ViewModel 更新 UserPreferences
  -> 呼叫 Repository 儲存
  -> 更新 state
```

分工：

```text
View
  -> 畫面與使用者事件

ViewModel
  -> 狀態與流程

Repository
  -> 資料讀寫
```

## 13. Repository

Repository 的角色：

```text
負責資料的讀取與儲存，並隱藏資料來源細節。
```

例如 settings 裡：

```text
從 SharedPreferences 讀目前主題設定
把新的主題設定寫回 SharedPreferences
把 storage 裡的字串轉成 AppThemeMode
```

ViewModel 不應該知道太多底層細節，例如：

```text
SharedPreferences 的 key 叫什麼
資料是存成 string 還是 int
讀取失敗時要怎麼給預設值
```

這些交給 Repository。

## 14. Riverpod 的基本角色

Provider 可以先理解成：

```text
一個可以被 App 各處讀取的依賴或狀態入口。
```

C# 粗略類比：

```text
Dependency Injection container + observable state
```

Riverpod 幫你處理：

```text
物件在哪裡建立
誰可以讀取它
狀態改變時誰要更新
測試時如何替換 fake
```

在 `main.dart`，App 會被包在：

```dart
ProviderScope(
  child: MyApp(),
)
```

這讓整個 App 可以使用 Riverpod provider。

## 15. ref.watch 與 ref.read

最重要的對比：

```text
ref.watch
  -> 讀取並監聽狀態
  -> 狀態改變時讓 Widget rebuild

ref.read
  -> 讀取一次，不監聽
  -> 常用在事件中呼叫 ViewModel 方法
```

可以這樣記：

```text
顯示狀態 -> ref.watch
觸發動作 -> ref.read
```

例如：

```dart
final preferences = ref.watch(settingsViewModelProvider);
```

意思是：

```text
讀取目前設定，並在設定改變時 rebuild。
```

事件裡常用：

```dart
ref.read(settingsViewModelProvider.notifier)
   .updateThemeMode(AppThemeMode.dark);
```

意思是：

```text
取得 SettingsViewModel
呼叫 updateThemeMode
請它把主題改成深色
```

## 16. provider 與 .notifier

可以先這樣分：

```text
settingsViewModelProvider
  -> 目前的狀態值

settingsViewModelProvider.notifier
  -> 管理這個狀態的 ViewModel / Notifier
```

也就是：

```text
我要讀目前狀態
  -> ref.watch(settingsViewModelProvider)

我要呼叫改狀態的方法
  -> ref.read(settingsViewModelProvider.notifier).updateThemeMode(...)
```

## 17. ConsumerWidget

如果 Widget 需要使用 Riverpod 的 `ref.watch` 或 `ref.read`，常會繼承：

```dart
ConsumerWidget
```

一般 `StatelessWidget`：

```dart
Widget build(BuildContext context)
```

`ConsumerWidget`：

```dart
Widget build(BuildContext context, WidgetRef ref)
```

差別是：

```text
ConsumerWidget 多拿到 WidgetRef ref，
所以可以使用 ref.watch / ref.read。
```

可以先這樣記：

```text
StatelessWidget
  -> 不需要 Riverpod ref

ConsumerWidget
  -> 需要 ref.watch / ref.read
```

## 18. AsyncValue

Riverpod 常用 `AsyncValue<T>` 表示非同步狀態。

主要有三種：

```text
loading 載入中
error   發生錯誤
data    成功拿到資料
```

傳統寫法可能會有：

```text
bool isLoading
T? data
String? errorMessage
```

`AsyncValue<T>` 把這三種狀態包在一起。

常見寫法：

```dart
final preferencesAsync = ref.watch(settingsViewModelProvider);

return preferencesAsync.when(
  loading: () => const CircularProgressIndicator(),
  error: (error, stackTrace) => Text('載入失敗：$error'),
  data: (preferences) {
    return Text('目前主題：${preferences.themeMode}');
  },
);
```

`.when(...)` 的意思是：

```text
loading 狀態 -> loading UI
error 狀態   -> error UI
data 狀態    -> normal UI
```

這很像 C# 的 pattern matching / switch。

## 19. SettingsView 的 AsyncValue 實際拆解

專案中的 `SettingsView` 會先監聽 settings state：

```dart
final preferencesAsync = ref.watch(settingsViewModelProvider);
```

這代表：

```text
SettingsView 讀取並監聽 settingsViewModelProvider。
如果設定狀態改變，SettingsView 會 rebuild。
```

接著 UI 使用 `.when(...)` 處理三種狀態：

```dart
body: preferencesAsync.when(
  loading: () => const Center(child: CircularProgressIndicator()),
  error: (error, stackTrace) => _SettingsErrorView(error: error),
  data: (preferences) => ListView(
    children: [
      // 設定內容
    ],
  ),
),
```

可以翻成：

```text
loading
  -> Center + CircularProgressIndicator

error
  -> _SettingsErrorView

data
  -> ListView 顯示設定選項
```

樹狀概念：

```text
SettingsView
  -> Scaffold
    appBar -> AppBar
      title -> Text('偏好設定')
    body -> AsyncValue.when
      loading -> Center
        -> CircularProgressIndicator
      error -> _SettingsErrorView
      data -> ListView
        -> Padding
          -> Text('主題模式')
        -> 多個 RadioListTile
```

重點：

```text
AsyncValue.when 根據目前狀態，選擇要顯示哪一種 Widget。
```

只有在 `data` 狀態裡，才會拿到成功載入的 `UserPreferences`：

```dart
data: (preferences) => ...
```

## 20. RadioListTile 與 enum 選項

Settings 頁面用 enum 產生主題選項：

```dart
for (final mode in AppThemeMode.values)
  RadioListTile<AppThemeMode>(
    title: Text(mode.label),
    value: mode,
    groupValue: preferences.themeMode,
    onChanged: (value) {
      // ...
    },
  ),
```

`AppThemeMode.values` 代表 enum 裡所有選項：

```text
AppThemeMode.system
AppThemeMode.light
AppThemeMode.dark
```

所以這個 `for` 會產生三個 radio 選項：

```text
跟隨系統
亮色模式
深色模式
```

`mode.label` 負責顯示文字：

```dart
String get label {
  return switch (this) {
    AppThemeMode.system => '跟隨系統',
    AppThemeMode.light => '亮色模式',
    AppThemeMode.dark => '深色模式',
  };
}
```

所以：

```text
AppThemeMode.system -> 跟隨系統
AppThemeMode.light  -> 亮色模式
AppThemeMode.dark   -> 深色模式
```

## 21. value 與 groupValue

`RadioListTile` 最重要的是：

```dart
value: mode,
groupValue: preferences.themeMode,
```

可以這樣理解：

```text
value
  -> 這一列代表哪個選項

groupValue
  -> 目前整組 radio 選到哪個值
```

如果：

```dart
preferences.themeMode == AppThemeMode.light
```

那三列狀態會是：

```text
system  value = system, groupValue = light -> 不選中
light   value = light,  groupValue = light -> 選中
dark    value = dark,   groupValue = light -> 不選中
```

判斷規則：

```text
value == groupValue
  -> 這一列被選中
```

## 22. onChanged 與 ViewModel 呼叫

使用者點選 radio 時會觸發：

```dart
onChanged: (value) {
  if (value == null) {
    return;
  }

  ref
      .read(settingsViewModelProvider.notifier)
      .setThemeMode(value);
},
```

`value` 代表使用者剛選到的新 `AppThemeMode`。

例如使用者點「深色模式」：

```text
value = AppThemeMode.dark
```

先做 null 檢查：

```dart
if (value == null) {
  return;
}
```

然後呼叫 ViewModel：

```dart
ref
    .read(settingsViewModelProvider.notifier)
    .setThemeMode(value);
```

白話：

```text
取得 SettingsViewModel
呼叫 setThemeMode(value)
請 ViewModel 更新主題設定
```

這裡用 `ref.read`，因為這是在事件裡觸發動作，不是在 build 裡顯示狀態。

## 23. SettingsViewModel.setThemeMode

專案中的 `setThemeMode`：

```dart
Future<void> setThemeMode(AppThemeMode themeMode) async {
  final currentPreferences = state.valueOrNull ?? const UserPreferences();

  await ref.read(settingsRepositoryProvider).saveThemeMode(themeMode);

  state = AsyncData(
    currentPreferences.copyWith(themeMode: themeMode),
  );
}
```

第一行：

```dart
Future<void> setThemeMode(AppThemeMode themeMode) async
```

C# 類比：

```csharp
async Task SetThemeMode(AppThemeMode themeMode)
```

意思是：

```text
這是一個非同步方法。
接收一個 AppThemeMode。
不回傳資料。
```

取得目前設定：

```dart
final currentPreferences = state.valueOrNull ?? const UserPreferences();
```

意思是：

```text
如果目前 state 有 UserPreferences，就拿出來。
如果沒有，就使用預設 UserPreferences。
```

保存設定：

```dart
await ref.read(settingsRepositoryProvider).saveThemeMode(themeMode);
```

意思是：

```text
透過 ref.read 取得 SettingsRepository。
呼叫 saveThemeMode(themeMode)。
等待儲存完成。
```

更新 ViewModel state：

```dart
state = AsyncData(
  currentPreferences.copyWith(themeMode: themeMode),
);
```

意思是：

```text
用舊 preferences 建立一份新 preferences。
只把 themeMode 改成新的值。
把 ViewModel state 更新成 data 狀態。
```

完整流程：

```text
setThemeMode(AppThemeMode.dark)
  -> 取得目前 preferences
  -> repository.saveThemeMode(dark)
  -> currentPreferences.copyWith(themeMode: dark)
  -> state = AsyncData(newPreferences)
  -> UI rebuild
```

## 24. Repository 的儲存與還原

Repository 儲存主題模式：

```dart
Future<void> saveThemeMode(AppThemeMode themeMode) {
  return _storageService.saveString(_themeModeKey, themeMode.storageValue);
}
```

其中：

```dart
const _themeModeKey = 'settings.theme_mode';
```

`themeMode.storageValue` 會把 enum 轉成字串：

```text
AppThemeMode.system -> 'system'
AppThemeMode.light  -> 'light'
AppThemeMode.dark   -> 'dark'
```

所以使用者選深色模式時，概念上會存成：

```text
key   = settings.theme_mode
value = dark
```

Repository 讀取主題模式：

```dart
Future<UserPreferences> loadPreferences() async {
  final storedThemeMode = await _storageService.getString(_themeModeKey);

  return UserPreferences(
    themeMode: AppThemeMode.fromStorageValue(storedThemeMode),
  );
}
```

白話：

```text
從 storage 讀出 settings.theme_mode 的字串。
把字串轉回 AppThemeMode。
包成 UserPreferences 回傳。
```

轉換方法：

```dart
static AppThemeMode fromStorageValue(String? value) {
  return AppThemeMode.values.firstWhere(
    (mode) => mode.storageValue == value,
    orElse: () => AppThemeMode.system,
  );
}
```

對照：

```text
'dark'  -> AppThemeMode.dark
'light' -> AppThemeMode.light
null    -> AppThemeMode.system
'abc'   -> AppThemeMode.system
```

如果本地資料不存在或壞掉，就回到 `system`，避免設定頁無法載入。

## 25. Settings 完整資料流

App 啟動或讀取設定：

```text
SettingsViewModel.build()
  -> ref.read(settingsRepositoryProvider).loadPreferences()
  -> LocalSettingsRepository.loadPreferences()
  -> StorageService.getString('settings.theme_mode')
  -> AppThemeMode.fromStorageValue(storedThemeMode)
  -> UserPreferences(themeMode: ...)
  -> SettingsViewModel state = AsyncData(UserPreferences)
```

Settings UI：

```text
SettingsView ref.watch(settingsViewModelProvider)
  -> loading 時顯示 CircularProgressIndicator
  -> error 時顯示 _SettingsErrorView
  -> data 時顯示 RadioListTile 選項
```

App 外殼：

```text
MyApp ref.watch(settingsViewModelProvider)
  -> preferences.themeMode.toThemeMode()
  -> MaterialApp.router(themeMode: ...)
```

使用者切換主題：

```text
使用者點 RadioListTile
  -> onChanged(value)
  -> ref.read(settingsViewModelProvider.notifier).setThemeMode(value)
  -> SettingsViewModel.setThemeMode(value)
  -> SettingsRepository.saveThemeMode(value)
  -> StorageService.saveString('settings.theme_mode', value.storageValue)
  -> state = AsyncData(currentPreferences.copyWith(themeMode: value))
  -> ref.watch 的地方 rebuild
  -> SettingsView 選中新的 radio
  -> MyApp 套用新的 ThemeMode
```

一句話：

```text
View 接收事件，ViewModel 處理狀態流程，Repository 負責資料讀寫，Provider 讓 UI 監聽變化。
```

## 26. AsyncValue 與 Repository 的責任差異

容易混淆的一點：

```text
AsyncValue 管狀態階段。
Repository / Domain Model 管資料轉換。
```

`AsyncValue` 負責表示：

```text
loading / error / data
```

它不負責把字串轉成 enum。

字串轉 enum 是這條線：

```text
LocalSettingsRepository
  -> AppThemeMode.fromStorageValue(...)
  -> UserPreferences
```

所以：

```text
'dark' -> AppThemeMode.dark
```

是 Repository 呼叫 Domain Model 的轉換邏輯完成的，不是 `AsyncValue` 完成的。

## 本章總結

- `StatelessWidget`：只顯示資料，不自己改。
- `StatefulWidget`：保存局部、短期、只屬於自己的 UI 狀態。
- `setState`：修改狀態並通知 Flutter rebuild。
- `build()`：根據目前資料，回傳 Widget tree。
- 跨頁共享、API、本地儲存、loading/error/data 狀態，適合 ViewModel / Riverpod。
- `UserPreferences` 是設定資料模型。
- `copyWith` 用舊物件建立新物件，只覆蓋指定欄位。
- ViewModel 負責狀態與流程。
- Repository 負責資料讀寫與隱藏資料來源細節。
- `ref.watch` 讀取並監聽狀態。
- `ref.read` 讀取一次，常用在事件中呼叫方法。
- `.notifier` 用來拿到管理狀態的 ViewModel / Notifier。
- `ConsumerWidget` 比 `StatelessWidget` 多了 `WidgetRef ref`。
- `AsyncValue` 表示 loading / error / data。
- `RadioListTile` 用 `value` 表示本列選項，用 `groupValue` 表示目前選中的值。
- `SettingsViewModel.setThemeMode` 會先保存設定，再更新 ViewModel state。
- Repository 負責把 `AppThemeMode.dark` 和 `'dark'` 這類儲存字串互相轉換。
- `AsyncValue` 管狀態階段，Repository / Domain Model 管資料轉換。

## 練習題

1. `StatelessWidget` 適合什麼情境？
2. `StatefulWidget + setState` 適合保存什麼類型的狀態？
3. 為什麼 App 深色模式不適合只放在某個小 `StatefulWidget`？
4. `setState` 主要告訴 Flutter 什麼？
5. 為什麼不應該在 `build()` 裡呼叫 API？
6. `copyWith` 的用途是什麼？
7. ViewModel 在 MVVM 思維裡負責什麼？
8. Repository 主要負責什麼？
9. `ref.watch` 和 `ref.read` 的主要差別是什麼？
10. `AsyncValue` 主要表示哪三種狀態？
11. `RadioListTile` 的 `value` 和 `groupValue` 差在哪裡？
12. 使用者選擇深色模式時，`setThemeMode(value)` 裡的 `value` 是什麼？
13. Repository 儲存 `AppThemeMode.dark` 時，最後存入的字串是什麼？
14. 如果 storage 讀到 `'light'`，`AppThemeMode.fromStorageValue(...)` 會回傳什麼？
15. 為什麼說 `AsyncValue` 不負責把 `'dark'` 轉成 `AppThemeMode.dark`？
