// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hymn.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Hymn _$HymnFromJson(Map<String, dynamic> json) => _Hymn(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  details: json['details'] as Map<String, dynamic>,
  lyrics: json['lyrics'] as Map<String, dynamic>,
);

Map<String, dynamic> _$HymnToJson(_Hymn instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'details': instance.details,
  'lyrics': instance.lyrics,
};
