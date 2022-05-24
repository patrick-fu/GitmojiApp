import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gitmojiapp/models/gitmoji_view_model.dart';

class GitmojiSearchBar extends StatelessWidget {
  const GitmojiSearchBar({Key? key}) : super(key: key);

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
          const Text(
            '🔍',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: TextField(
              onChanged: (value) {
                var gitmojiViewModel = context.read<GitmojiViewModel>();
                gitmojiViewModel.filterText = value;
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search..',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
