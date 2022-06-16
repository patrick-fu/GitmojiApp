import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gitmojiapp/home_page.dart';
import 'package:gitmojiapp/models/gitmoji_view_model.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

Future<void> _ensureInitialized() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
    await windowManager.ensureInitialized();
    setupWindow();
  }
}

void setupWindow() {
  Size minSize = const Size(350, 450);
  windowManager.setMinimumSize(minSize);
  WindowOptions windowOptions = WindowOptions(
    size: minSize,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setAsFrameless();
    await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
    await windowManager.show();
    await windowManager.focus();
  });
}

void main() async {
  await _ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (context) => GitmojiViewModel(),
        child: const HomePage(),
      ),
    );
  }
}
