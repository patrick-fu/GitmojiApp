import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gitmojiapp/models/gitmoji_data_model.dart';
import 'package:gitmojiapp/models/gitmoji_persistence.dart';
import 'package:gitmojiapp/models/gitmoji_view_model.dart';
import 'package:gitmojiapp/settings_page.dart';
import 'package:gitmojiapp/widgets/gitmoji_row.dart';
import 'package:gitmojiapp/widgets/gitmoji_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isAlwaysOnTop = false;

  @override
  void initState() {
    GitmojiPersistence().initialize().then((value) {
      GitmojiDataModel.getGitmojiData().then((value) {
        setState(() {
          context.read<GitmojiViewModel>().allGitmojis = value.gitmojis;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DragToMoveArea(
            child: Text('GitmojiApp', style: TextStyle(fontSize: 16))),
        toolbarHeight: 40,
        leading: alwaysOnTopButton(context),
        actions: [settingsButton(context)],
      ),
      body: Consumer<GitmojiViewModel>(
        builder: (context, model, child) {
          return Column(
            children: [
              const GitmojiSearchBar(),
              Expanded(
                child: ListView(children: [
                  for (int index = 0;
                      index < model.filteredGitmojis.length;
                      index++)
                    GitmojiRow(dataSource: model.filteredGitmojis[index])
                ]),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget alwaysOnTopButton(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn,
        transformAlignment: Alignment.center,
        transform: Matrix4.rotationZ(
          _isAlwaysOnTop ? 0.8 : 0,
        ),
        child: Icon(
          _isAlwaysOnTop ? Icons.push_pin : Icons.push_pin_outlined,
          size: 20,
          color: Colors.white,
        ),
      ),
      onPressed: () {
        setState(() {
          _isAlwaysOnTop = !_isAlwaysOnTop;
        });
        windowManager.setAlwaysOnTop(_isAlwaysOnTop);
      },
    );
  }

  Widget settingsButton(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () {
          final model = Provider.of<GitmojiViewModel>(context, listen: false);
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return ListenableProvider.value(
                    value: model,
                    child: SettingsPage(onDismiss: () {
                      Navigator.of(context).pop();
                    }));
              });
        });
  }
}
