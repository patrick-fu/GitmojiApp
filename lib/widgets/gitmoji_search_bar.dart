import 'package:flutter/material.dart';
import 'package:gitmojiapp/models/gitmoji_view_model.dart';
import 'package:gitmojiapp/utils/platform_util.dart';
import 'package:provider/provider.dart';

class GitmojiSearchBar extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController searchTextController;

  const GitmojiSearchBar({
    Key? key,
    required this.focusNode,
    required this.searchTextController,
  }) : super(key: key);

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
          Text('🔍',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: kIsLinux ? 'NotoColorEmoji' : null)),
          const SizedBox(width: 8),
          Expanded(child: inputTextField(context)),
          clearTextButton(context),
        ],
      ),
    );
  }

  Widget inputTextField(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: searchTextController,
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
        searchTextController.clear();
        var gitmojiViewModel = context.read<GitmojiViewModel>();
        gitmojiViewModel.filterText = '';
      },
    );
  }
}
