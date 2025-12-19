import 'dart:convert';
import 'package:nah/domain/models/hymn/hymn.dart';

/// Method to take in a hymn mapp and deserialize it into a hymn
Hymn hymnFromMap(Map<String, dynamic> map) {
  return switch (map) {
    {
      "id": int id,
      "title": String title,
      "details": String details,
      "lyrics": String lyrics,
      "hymnalId": int hymnalId,
    } =>
      Hymn(
        id: id,
        title: title,
        details: jsonDecode(details),
        lyrics: jsonDecode(lyrics),
      ),
    _ => throw const FormatException("Unrecognized Hymn Format"),
  };
}

Map<String, dynamic> hymnMapper(Hymn hymn, int hymnalId) {
  return {
    "id": hymn.id,
    "title": hymn.title,
    "details": jsonEncode(hymn.details),
    "lyrics": jsonEncode(hymn.lyrics),
    "hymnalId": hymnalId,
  };
}
