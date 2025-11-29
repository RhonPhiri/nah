import 'dart:convert';
import 'package:nah/domain/models/hymn/hymn.dart';
import 'package:nah/domain/models/hymn_bookmark/hymn_bookmark.dart';
import 'package:nah/domain/models/hymn_collection/hymn_collection.dart';
import 'package:nah/domain/models/hymnal/hymnal.dart';

/// Method to transform all maps of an object into that object..
/// I have made this because I implemented custom Map keys used creating and storing data in the database tables
/// than those used by the freezed package in the from Json method
List<T> mapper<T>(List<Map<String, Object?>> maps) {
  // Return an empty list if the maps are empty
  if (maps.isEmpty) return <T>[];

  // I tried to use "is" but an error was thrown because "is" is used in comparing an instance: subtype relationship
  // while "==" is used in comparing exact types

  if (T == Hymnal) {
    final list = maps.map((map) {
      return switch (map) {
        {
          "hymnal_id": int id,
          "hymnal_title": String title,
          "hymnal_language": String language,
        } =>
          Hymnal(id: id, title: title, language: language),
        _ => throw const FormatException("Unrecognized Hymnal Map"),
      };
    }).toList();
    return list.cast<T>();
  }

  if (T == Hymn) {
    final list = maps.map((map) {
      return switch (map) {
        {
          "hymn_id": int id,
          "hymn_title": String title,
          "hymn_details": String details,
          "hymn_lyrics": String lyrics,
          "hymnal_id": int hymnal_id,
        } =>
          Hymn(
            id: id,
            title: title,
            details: jsonDecode(details) as Map<String, dynamic>,
            lyrics: jsonDecode(lyrics) as Map<String, dynamic>,
          ),
        _ => throw const FormatException("Unrecognized Hymn Map"),
      };
    }).toList();

    return list.cast<T>();
  }
  if (T == HymnCollection) {
    final list = maps.map((map) {
      return switch (map) {
        {
          "hymn_collection_id": int id,
          "hymn_collection_title": String title,
          "hymn_collection_description": String description,
        } =>
          HymnCollection(id: id, title: title, description: description),
        _ => throw const FormatException("Unrecognized Hymn Collection Format"),
      };
    }).toList();
    return list.cast<T>();
  }

  if (T == HymnBookmark) {
    final list = maps.map((map) {
      return switch (map) {
        {
          "hymn_bookmark_id": int id,
          "hymn_bookmark_title": String title,
          "hymn_collection_id": int hymnCollectionId,
          "hymnal_id": int hymnalId,
        } =>
          HymnBookmark(
            id: id,
            title: title,
            hymnCollectionId: hymnCollectionId,
            hymnalId: hymnalId,
          ),
        _ => throw const FormatException("Unrecognized Hymn Bookmark Format"),
      };
    }).toList();
    return list.cast<T>();
  }

  throw UnsupportedError("Mapper: Unsupported target type $T");
}
