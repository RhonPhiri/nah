import 'dart:convert';

class Hymnal {
  final int id;
  final String title;
  final String language;

  const Hymnal({required this.id, required this.title, required this.language});

  Hymnal copyWith({int? id, String? title, String? language}) {
    return Hymnal(
      id: id ?? this.id,
      title: title ?? this.title,
      language: language ?? this.language,
    );
  }

  Map<String, Object?> toMap() {
    return {'id': id, 'title': title, 'language': language};
  }

  factory Hymnal.fromMap(Map<String, Object?> map) {
    return switch (map) {
      {'id': int id, 'title': String title, 'language': String language} =>
        Hymnal(id: id, title: title, language: language),
      _ => throw FormatException('Hymnal format not recognized'),
    };
  }

  String toJson() => json.encode(toMap());

  factory Hymnal.fromJson(String source) => Hymnal.fromMap(json.decode(source));

  @override
  String toString() => 'Hymnal(id: $id, title: $title, language: $language)';

  @override
  // Overrides the equality operator to compare two Hymnal objects
  // based on their id, language, and title properties.
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Hymnal &&
        other.id == id &&
        other.title == title &&
        other.language == language;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ language.hashCode;
}
