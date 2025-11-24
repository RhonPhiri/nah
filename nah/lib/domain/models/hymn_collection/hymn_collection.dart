import 'package:freezed_annotation/freezed_annotation.dart';

part 'hymn_collection.freezed.dart';

part 'hymn_collection.g.dart';

/// [HymnCollection] is a class that represents a collection of hymns.
/// Each collection has a and Id, a title, an nullable description;
///
@freezed
abstract class HymnCollection with _$HymnCollection {
  const factory HymnCollection({
    // Unique identifier for the hymn collection
    required int id,
    // Title of the hymn collection
    required String title,
    // Optional description providing more details about the hymn collection
    String? description,
  }) = _HymnCollection;

  factory HymnCollection.fromJson(Map<String, Object?> json) =>
      _$HymnCollectionFromJson(json);
}
