import 'package:freezed_annotation/freezed_annotation.dart';

part 'hymn_bookmark.freezed.dart';

part 'hymn_bookmark.g.dart';

/// [HymnBookmark] is a class of a representation of a bookmark assigned to a colleciton

@freezed
abstract class HymnBookmark with _$HymnBookmark {
  const factory HymnBookmark({
    // Unique identifier that is equal to the hymn id.
    required int id,
    // Title of the hymn that has been bookmarked.
    required String title,
    // Identifier of the collection to which the hymn has been bookmarked.
    required int hymnCollectionId,
    // Identifier of the hymnal to which the hymn belongs to
    required int hymnalId,
  }) = _HymnBookmark;

  factory HymnBookmark.fromJson(Map<String, Object?> json) =>
      _$HymnBookmarkFromJson(json);
}
