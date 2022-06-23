import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gitmojiapp/models/gitmoji_data_model.dart';
import 'package:gitmojiapp/models/gitmoji_persistence.dart';
import 'package:gitmojiapp/models/gitmoji_view_model.dart';
import 'package:gitmojiapp/utils/platform_util.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
  String _appVersion = '';

  @override
  void initState() {
    PackageInfo.fromPlatform().then((value) {
      setState(() => _appVersion = value.version);
    });
    super.initState();
  }

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
          appVersionRow(),
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
              items: [
                DropdownMenuItem(
                  value: EmojiValueToCopyType.emoji,
                  child: Text('emoji (e.g. "🐛")',
                      style: TextStyle(
                          fontFamily: kIsLinux ? 'NotoColorEmoji' : null)),
                ),
                const DropdownMenuItem(
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
    TextStyle style = TextStyle(fontFamily: kIsLinux ? 'NotoColorEmoji' : null);
    switch (_updateState) {
      case GitmojiDataUpdateState.none:
        return Text("🌞 Update!", style: style);
      case GitmojiDataUpdateState.updating:
        return Text("⏳ Updating...", style: style);
      case GitmojiDataUpdateState.success:
        return Text("✅ Success!", style: style);
      case GitmojiDataUpdateState.failed:
        return Text("❌ Failed!", style: style);
    }
  }

  Widget appVersionRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          const Text('Version:'),
          const Spacer(),
          Text(_appVersion),
        ],
      ),
    );
  }
}

enum GitmojiDataUpdateState {
  none,
  updating,
  success,
  failed,
}
