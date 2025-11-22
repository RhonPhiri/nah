// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hymn_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HymnCollection _$HymnCollectionFromJson(Map<String, dynamic> json) =>
    _HymnCollection(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$HymnCollectionToJson(_HymnCollection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
    };
