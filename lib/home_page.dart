import 'package:flutter/material.dart';
import 'package:gitmojiapp/models/gitmoji_persistence.dart';
import 'package:gitmojiapp/models/gitmoji_view_model.dart';
import 'package:provider/provider.dart';
import 'package:gitmojiapp/models/gitmoji_data_model.dart';
import 'package:gitmojiapp/widgets/gitmoji_row.dart';
import 'package:gitmojiapp/widgets/gitmoji_search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    GitmojiPersistence().initialize();
    GitmojiDataModel.getGitmojiData().then((value) {
      setState(() {
        context.read<GitmojiViewModel>().allGitmojis = value.gitmojis;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
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
}
