import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

/// App 的啟動入口。
///
/// 這裡只做一件事：把整個 Flutter app 放進 Riverpod 的 [ProviderScope]。
/// ProviderScope 是 Riverpod 的根容器，後續所有 Provider、Repository、
/// ViewModel 都會從這裡取得依賴。
void main() {
  runApp(const ProviderScope(child: MyApp()));
}
