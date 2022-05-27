import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gitmojiapp/models/gitmoji_data_model.dart';
import 'package:gitmojiapp/models/gitmoji_persistence.dart';

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
        EmojiValueToCopyType chosenType =
            GitmojiPersistence().emojiValueToCopyType;
        String dataToCopy = '';
        switch (chosenType) {
          case EmojiValueToCopyType.emoji:
            dataToCopy = dataSource.emoji;
            break;
          case EmojiValueToCopyType.code:
            dataToCopy = dataSource.code;
            break;
          default:
            dataToCopy = dataSource.emoji;
        }
        Clipboard.setData(ClipboardData(text: dataToCopy));
      },
    );
  }
}
