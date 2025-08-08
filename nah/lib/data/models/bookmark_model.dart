import 'dart:convert';

class Bookmark {
  ///variable to hold the hymn id
  final int id;

  ///variable to hold the hymn title
  final String title;

  ///variable to store the collection title
  final String hcTitle;

  ///variable to hold the hymnal language
  final String language;

  Bookmark({
    required this.id,
    required this.title,
    required this.language,
    required this.hcTitle,
  });

  ///Converts the BookmarkedHymn object to a map for storage
  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'language': language, 'hcTitle': hcTitle};
  }

  ///Creates a BookmarkedHymn object from a map
  factory Bookmark.fromMap(Map<String, dynamic> map) {
    return switch (map) {
      {
        "id": int hymnId,
        "title": String hymnTitle,
        "language": String hymnalLang,
        "hcTitle": String hcTitle,
      } =>
        Bookmark(
          id: hymnId,
          title: hymnTitle,
          language: hymnalLang,
          hcTitle: hcTitle,
        ),
      _ => throw FormatException("Unexpected bookmarked hymn format"),
    };
  }

  String toJson() => json.encode(toMap());

  factory Bookmark.fromJson(String source) =>
      Bookmark.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Bookmark &&
        other.id == id &&
        other.title == title &&
        other.language == language &&
        other.hcTitle == hcTitle;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ language.hashCode ^ hcTitle.hashCode;
  }
}
