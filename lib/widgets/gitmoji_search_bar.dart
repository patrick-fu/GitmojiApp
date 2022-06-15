import 'package:flutter/material.dart';
import 'package:gitmojiapp/settings_page.dart';
import 'package:provider/provider.dart';
import 'package:gitmojiapp/models/gitmoji_view_model.dart';

class GitmojiSearchBar extends StatefulWidget {
  const GitmojiSearchBar({Key? key}) : super(key: key);

  @override
  State<GitmojiSearchBar> createState() => _GitmojiSearchBarState();
}

class _GitmojiSearchBarState extends State<GitmojiSearchBar> {
  final TextEditingController _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(14),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
          color: Colors.black12,
          border: Border.all(
            color: Colors.black12,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          const Text('🔍', style: TextStyle(fontSize: 24)),
          const SizedBox(width: 8),
          Expanded(child: inputTextField(context)),
          clearTextButton(context),
          settingsButton(context)
        ],
      ),
    );
  }

  Widget inputTextField(BuildContext context) {
    return TextField(
      controller: _searchTextController,
      onChanged: (value) {
        var gitmojiViewModel = context.read<GitmojiViewModel>();
        gitmojiViewModel.filterText = value;
      },
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Search...',
      ),
    );
  }

  Widget clearTextButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        _searchTextController.clear();
        var gitmojiViewModel = context.read<GitmojiViewModel>();
        gitmojiViewModel.filterText = '';
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
