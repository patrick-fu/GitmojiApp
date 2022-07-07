import 'package:flutter/material.dart';
import 'package:gitmojiapp/home_page.dart';
import 'package:gitmojiapp/models/gitmoji_view_model.dart';
import 'package:gitmojiapp/utils/platform_util.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

Future<void> _ensureInitialized() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsMacOS || kIsWindows || kIsLinux) {
    await windowManager.ensureInitialized();
  }
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
