import 'package:flutter/material.dart';
import 'package:gitmojiapp/gitmoji_data_model.dart';
import 'package:gitmojiapp/widgets/gitmoji_row.dart';
import 'package:gitmojiapp/widgets/gitmoji_search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GitmojiDataModel? gitmojiData;

  @override
  void initState() {
    GitmojiDataModel.getGitmojiData().then((value) {
      setState(() => gitmojiData = value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        children: [
          GitmojiSearchBar(dataSource: gitmojiData?.gitmojis ?? []),
          Expanded(
            child: ListView(children: _buildListTiles(context)),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildListTiles(BuildContext context) {
    if (gitmojiData == null) {
      return const <Widget>[];
    } else {
      return [
        for (int index = 0; index < gitmojiData!.gitmojis.length; index++)
          GitmojiRow(dataSource: gitmojiData!.gitmojis[index])
      ];
    }
  }
}
