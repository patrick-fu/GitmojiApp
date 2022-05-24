import 'package:flutter/foundation.dart';
import 'package:gitmojiapp/models/gitmoji_data_model.dart';

class GitmojiViewModel with ChangeNotifier {
  List<Gitmoji> filteredGitmojis = [];

  late List<Gitmoji> _allGitmojis;

  set allGitmojis(List<Gitmoji> value) {
    _allGitmojis = value;
    filteredGitmojis = value; // Refresh the filtered list
    notifyListeners();
  }

  String _filterText = '';

  String get filterText {
    return _filterText;
  }

  set filterText(String text) {
    _filterText = text;
    _filterGitmojis(text);
    notifyListeners();
  }

  void _filterGitmojis(String text) {
    if (text.isNotEmpty) {
      filteredGitmojis = _allGitmojis
          .where((gitmoji) =>
              gitmoji.description.toLowerCase().contains(text.toLowerCase()))
          .toList();
    } else {
      filteredGitmojis = _allGitmojis;
    }
  }
}
