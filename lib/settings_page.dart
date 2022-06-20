import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gitmojiapp/models/gitmoji_data_model.dart';
import 'package:gitmojiapp/models/gitmoji_persistence.dart';
import 'package:gitmojiapp/models/gitmoji_view_model.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  final VoidCallback? onDismiss;

  const SettingsPage({Key? key, this.onDismiss}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  EmojiValueToCopyType _chosenType = GitmojiPersistence().emojiValueToCopyType;
  GitmojiDataUpdateState _updateState = GitmojiDataUpdateState.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: widget.onDismiss != null
            ? IconButton(
                onPressed: widget.onDismiss, icon: const Icon(Icons.close))
            : null,
        actions: [
          Tooltip(
            message: 'Exit the app',
            child: IconButton(
              onPressed: () => exit(0),
              icon: const Icon(Icons.exit_to_app),
              color: Colors.red,
            ),
          ),
        ],
        title: const Text('Settings', style: TextStyle(fontSize: 16)),
        toolbarHeight: 40,
      ),
      body: ListView(
        children: [
          valueToCopyRow(),
          const Divider(),
          updateGitmojiDataRow(),
          const Divider(),
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

  Widget updateGitmojiDataRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          const Text('Update gitmoji data'),
          const SizedBox(
            width: 10,
          ),
          const Spacer(),
          ElevatedButton(
              onPressed: _updateState == GitmojiDataUpdateState.updating
                  ? null
                  : () async {
                      setState(() {
                        _updateState = GitmojiDataUpdateState.updating;
                      });
                      bool result = await GitmojiDataModel.updateGitmojiData();
                      if (result) {
                        GitmojiDataModel value =
                            await GitmojiDataModel.getGitmojiData();
                        setState(() {
                          context.read<GitmojiViewModel>().allGitmojis =
                              value.gitmojis;
                          _updateState = GitmojiDataUpdateState.success;
                        });
                      } else {
                        setState(() {
                          _updateState = GitmojiDataUpdateState.failed;
                        });
                      }
                    },
              child: _updateGitmojiDataButtonText()),
        ],
      ),
    );
  }

  Widget _updateGitmojiDataButtonText() {
    switch (_updateState) {
      case GitmojiDataUpdateState.none:
        return const Text("🌞 Update!");
      case GitmojiDataUpdateState.updating:
        return const Text("⏳ Updating...");
      case GitmojiDataUpdateState.success:
        return const Text("✅ Success!");
      case GitmojiDataUpdateState.failed:
        return const Text("❌ Failed!");
    }
  }
}

enum GitmojiDataUpdateState {
  none,
  updating,
  success,
  failed,
}
