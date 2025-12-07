import 'package:freezed_annotation/freezed_annotation.dart';

part 'hymn.freezed.dart';

part 'hymn.g.dart';
// This is the hymn model class

@freezed
abstract class Hymn with _$Hymn {
  // The factory constractor enables the instantiation of a hymn object
  const factory Hymn({
    // Each hymn has a designated id as it appears in the numbering of a hymnal
    required int id,
    // Hymn title indicates the title of the hymn as it appears in the hymnal
    required String title,
    // Each hymn has other details including
    // Its ID common hymnal e.g. NEH, CHC, RB; from where they were translated
    required Map<String, dynamic> details,
    // These are the verses and chorus of the hymns
    required Map<String, dynamic> lyrics,
  }) = _Hymn;

  factory Hymn.fromJson(Map<String, Object?> json) => _$HymnFromJson(json);
}
