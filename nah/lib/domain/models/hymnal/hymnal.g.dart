// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hymnal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Hymnal _$HymnalFromJson(Map<String, dynamic> json) => _Hymnal(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  language: json['language'] as String,
);

Map<String, dynamic> _$HymnalToJson(_Hymnal instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'language': instance.language,
};
