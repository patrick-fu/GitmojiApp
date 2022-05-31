import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:gitmojiapp/models/gitmoji_persistence.dart';

class GitmojiDataModel {
  static String url =
      'https://raw.githubusercontent.com/carloscuesta/gitmoji/master/src/data/gitmojis.json';

  /// Get the gitmoji data from the cache or from the network.
  static Future<GitmojiDataModel> getGitmojiData() async {
    final String gitmojis = GitmojiPersistence().gitmojisJson;
    if (gitmojis.isNotEmpty) {
      return GitmojiDataModel.fromJson(gitmojis);
    } else {
      final String gitmojis =
          await rootBundle.loadString('assets/gitmojis.json');
      GitmojiPersistence().gitmojisJson = gitmojis;
      return GitmojiDataModel.fromJson(gitmojis);
    }
  }

  /// Update the gitmojis data from the internet.
  /// And store it in the shared preferences.
  static Future<bool> updateGitmojiData() async {
    try {
      BaseOptions options = BaseOptions(
        connectTimeout: 4000,
        receiveTimeout: 4000,
      );
      final response = await Dio(options).get(url);
      final gitmojis = response.data.toString();
      GitmojiPersistence().gitmojisJson = gitmojis;
      return true;
    } catch (e) {
      return false;
    }
  }

  GitmojiDataModel({
    required this.gitmojis,
  });

  List<Gitmoji> gitmojis;

  factory GitmojiDataModel.fromJson(String str) =>
      GitmojiDataModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GitmojiDataModel.fromMap(Map<String, dynamic> json) =>
      GitmojiDataModel(
        gitmojis:
            List<Gitmoji>.from(json["gitmojis"].map((x) => Gitmoji.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "gitmojis": List<dynamic>.from(gitmojis.map((x) => x.toMap())),
      };
}

class Gitmoji {
  Gitmoji({
    required this.emoji,
    required this.entity,
    required this.code,
    required this.description,
    required this.name,
    this.semver,
  });

  String emoji;
  String entity;
  String code;
  String description;
  String name;
  Semver? semver;

  factory Gitmoji.fromJson(String str) => Gitmoji.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Gitmoji.fromMap(Map<String, dynamic> json) => Gitmoji(
        emoji: json["emoji"],
        entity: json["entity"],
        code: json["code"],
        description: json["description"],
        name: json["name"],
        semver:
            json["semver"] == null ? null : semverValues.map[json["semver"]],
      );

  Map<String, dynamic> toMap() => {
        "emoji": emoji,
        "entity": entity,
        "code": code,
        "description": description,
        "name": name,
        "semver": semver == null ? null : semverValues.reverse[semver],
      };
}

enum Semver { major, minor, patch }

final semverValues = EnumValues(
    {"major": Semver.major, "minor": Semver.minor, "patch": Semver.patch});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    return reverseMap ?? map.map((k, v) => MapEntry(v, k));
  }
}
