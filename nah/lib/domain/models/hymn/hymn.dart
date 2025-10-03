import 'dart:convert';
import 'package:flutter/foundation.dart';

class Hymn {
  final int id;
  final String title;
  final String otherDetails;
  final Map<String, Object?> lyrics;

  const Hymn({
    required this.id,
    required this.title,
    required this.otherDetails,
    required this.lyrics,
  });

  ///Converts the Hymn object to a map for storage
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'otherDetails': otherDetails,
      'lyrics': json.encode(lyrics),

      ///the map literal will be stored as text
    };
  }

  ///Creates a Hymn object from a map
  factory Hymn.fromMap(Map<String, Object?> map) {
    return switch (map) {
      {
        "id": int id,
        "title": String title,
        "otherDetails": String otherDetails,
        "lyrics": Map<String, Object?> lyrics,
      } =>
        Hymn(id: id, title: title, otherDetails: otherDetails, lyrics: lyrics),
      _ => throw Exception('Json format unrecognised'),
    };
  }

  String toJson() => json.encode(toMap());

  factory Hymn.fromJson(String source) => Hymn.fromMap(json.decode(source));

  Hymn copyWith({
    int? id,
    String? title,
    String? otherDetails,
    Map<String, dynamic>? lyrics,
  }) {
    return Hymn(
      id: id ?? this.id,
      title: title ?? this.title,
      otherDetails: otherDetails ?? this.otherDetails,
      lyrics: lyrics ?? this.lyrics,
    );
  }

  @override
  String toString() {
    return 'Hymn(id: $id, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Hymn &&
        other.id == id &&
        other.title == title &&
        other.otherDetails == otherDetails &&
        mapEquals(
          other.lyrics,
          lyrics,
        ); //This is a function the compares one map to another
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        otherDetails.hashCode ^
        lyrics.hashCode;
  }
}
