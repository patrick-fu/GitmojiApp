import 'package:flutter/material.dart';
import 'package:gitmojiapp/models/gitmoji_persistence.dart';

class SettingsPage extends StatefulWidget {
  final VoidCallback? onDismiss;

  const SettingsPage({Key? key, this.onDismiss}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  EmojiValueToCopyType _chosenType = GitmojiPersistence().emojiValueToCopyType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: widget.onDismiss != null
            ? IconButton(
                onPressed: widget.onDismiss, icon: const Icon(Icons.close))
            : null,
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          valueToCopyRow(),
        ],
      ),
    );
  }

  Widget valueToCopyRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          const Text('Value to copy'),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: DropdownButton<EmojiValueToCopyType>(
              value: _chosenType,
              items: const [
                DropdownMenuItem(
                  value: EmojiValueToCopyType.emoji,
                  child: Text('emoji (e.g. "🐛")'),
                ),
                DropdownMenuItem(
                  value: EmojiValueToCopyType.code,
                  child: Text('code (e.g. ":bug:")'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _chosenType = value ?? EmojiValueToCopyType.emoji;
                  GitmojiPersistence().emojiValueToCopyType = _chosenType;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
