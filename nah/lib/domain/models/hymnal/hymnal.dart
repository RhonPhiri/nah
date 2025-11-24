import 'package:freezed_annotation/freezed_annotation.dart';

part 'hymnal.freezed.dart';

part 'hymnal.g.dart';

@freezed
abstract class Hymnal with _$Hymnal {
  // factory constructor instantiation of a hymnal object
  const factory Hymnal({
    // each hymnal has an Id
    required int id,
    // Title of the hymnal as it appears on the hymnal book
    required String title,
    // Language of the songs in the hymnal
    required String language,
  }) = _Hymnal;

  factory Hymnal.fromJson(Map<String, Object?> json) => _$HymnalFromJson(json);
}
