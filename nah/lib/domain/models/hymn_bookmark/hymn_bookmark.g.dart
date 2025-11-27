// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hymn_bookmark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HymnBookmark _$HymnBookmarkFromJson(Map<String, dynamic> json) =>
    _HymnBookmark(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      hymnCollectionId: (json['hymnCollectionId'] as num).toInt(),
      hymnalId: (json['hymnalId'] as num).toInt(),
    );

Map<String, dynamic> _$HymnBookmarkToJson(_HymnBookmark instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'hymnCollectionId': instance.hymnCollectionId,
      'hymnalId': instance.hymnalId,
    };
