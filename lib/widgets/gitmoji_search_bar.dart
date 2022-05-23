import 'package:flutter/material.dart';
import 'package:gitmojiapp/gitmoji_data_model.dart';

class GitmojiSearchBar extends StatelessWidget {
  const GitmojiSearchBar({Key? key, required this.dataSource})
      : super(key: key);

  final List<Gitmoji> dataSource;

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
        children: const [
          Text(
            '🔍',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
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
