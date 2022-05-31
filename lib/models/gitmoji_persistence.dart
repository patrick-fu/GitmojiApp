import 'package:shared_preferences/shared_preferences.dart';

enum EmojiValueToCopyType {
  emoji,
  code,
}

class GitmojiPersistence {
  GitmojiPersistence._privateConstructor();
  static final GitmojiPersistence _instance =
      GitmojiPersistence._privateConstructor();
  factory GitmojiPersistence() {
    return _instance;
  }

  SharedPreferences? _prefs;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String get gitmojisJson {
    return _prefs?.getString('gitmojis') ?? '';
  }

  set gitmojisJson(String value) {
    _prefs?.setString('gitmojis', value);
  }

  EmojiValueToCopyType get emojiValueToCopyType {
    int value = _prefs?.getInt('emojiValueToCopyType') ?? 0;
    return EmojiValueToCopyType.values[value];
  }

  set emojiValueToCopyType(EmojiValueToCopyType value) {
    _prefs?.setInt('emojiValueToCopyType', value.index);
  }
}
