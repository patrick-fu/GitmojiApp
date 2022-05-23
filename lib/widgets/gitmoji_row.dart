import 'package:flutter/material.dart';
import 'package:gitmojiapp/gitmoji_data_model.dart';

class GitmojiRow extends StatelessWidget {
  const GitmojiRow({Key? key, required this.dataSource}) : super(key: key);

  final Gitmoji dataSource;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        dataSource.emoji,
        style: const TextStyle(fontSize: 30),
      ),
      title: Text(dataSource.description),
      minLeadingWidth: 30,
      mouseCursor: SystemMouseCursors.basic,
      onTap: () {
        // TODO: Copy the emoji
      },
    );
  }
}
