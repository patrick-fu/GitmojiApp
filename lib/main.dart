import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gitmojiapp/home_page.dart';
import 'package:gitmojiapp/models/gitmoji_view_model.dart';

void main() {
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
