// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hymn_bookmark.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HymnBookmark {

// Unique identifier that is equal to the hymn id.
 int get id;// Title of the hymn that has been bookmarked.
 String get title;// Identifier of the collection to which the hymn has been bookmarked.
 int get hymnCollectionId;
/// Create a copy of HymnBookmark
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HymnBookmarkCopyWith<HymnBookmark> get copyWith => _$HymnBookmarkCopyWithImpl<HymnBookmark>(this as HymnBookmark, _$identity);

  /// Serializes this HymnBookmark to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HymnBookmark&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.hymnCollectionId, hymnCollectionId) || other.hymnCollectionId == hymnCollectionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,hymnCollectionId);

@override
String toString() {
  return 'HymnBookmark(id: $id, title: $title, hymnCollectionId: $hymnCollectionId)';
}


}

/// @nodoc
abstract mixin class $HymnBookmarkCopyWith<$Res>  {
  factory $HymnBookmarkCopyWith(HymnBookmark value, $Res Function(HymnBookmark) _then) = _$HymnBookmarkCopyWithImpl;
@useResult
$Res call({
 int id, String title, int hymnCollectionId
});




}
/// @nodoc
class _$HymnBookmarkCopyWithImpl<$Res>
    implements $HymnBookmarkCopyWith<$Res> {
  _$HymnBookmarkCopyWithImpl(this._self, this._then);

  final HymnBookmark _self;
  final $Res Function(HymnBookmark) _then;

/// Create a copy of HymnBookmark
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? hymnCollectionId = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,hymnCollectionId: null == hymnCollectionId ? _self.hymnCollectionId : hymnCollectionId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HymnBookmark].
extension HymnBookmarkPatterns on HymnBookmark {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HymnBookmark value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HymnBookmark() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HymnBookmark value)  $default,){
final _that = this;
switch (_that) {
case _HymnBookmark():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HymnBookmark value)?  $default,){
final _that = this;
switch (_that) {
case _HymnBookmark() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  int hymnCollectionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HymnBookmark() when $default != null:
return $default(_that.id,_that.title,_that.hymnCollectionId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  int hymnCollectionId)  $default,) {final _that = this;
switch (_that) {
case _HymnBookmark():
return $default(_that.id,_that.title,_that.hymnCollectionId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  int hymnCollectionId)?  $default,) {final _that = this;
switch (_that) {
case _HymnBookmark() when $default != null:
return $default(_that.id,_that.title,_that.hymnCollectionId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HymnBookmark implements HymnBookmark {
  const _HymnBookmark({required this.id, required this.title, required this.hymnCollectionId});
  factory _HymnBookmark.fromJson(Map<String, dynamic> json) => _$HymnBookmarkFromJson(json);

// Unique identifier that is equal to the hymn id.
@override final  int id;
// Title of the hymn that has been bookmarked.
@override final  String title;
// Identifier of the collection to which the hymn has been bookmarked.
@override final  int hymnCollectionId;

/// Create a copy of HymnBookmark
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HymnBookmarkCopyWith<_HymnBookmark> get copyWith => __$HymnBookmarkCopyWithImpl<_HymnBookmark>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HymnBookmarkToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HymnBookmark&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.hymnCollectionId, hymnCollectionId) || other.hymnCollectionId == hymnCollectionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,hymnCollectionId);

@override
String toString() {
  return 'HymnBookmark(id: $id, title: $title, hymnCollectionId: $hymnCollectionId)';
}


}

/// @nodoc
abstract mixin class _$HymnBookmarkCopyWith<$Res> implements $HymnBookmarkCopyWith<$Res> {
  factory _$HymnBookmarkCopyWith(_HymnBookmark value, $Res Function(_HymnBookmark) _then) = __$HymnBookmarkCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, int hymnCollectionId
});




}
/// @nodoc
class __$HymnBookmarkCopyWithImpl<$Res>
    implements _$HymnBookmarkCopyWith<$Res> {
  __$HymnBookmarkCopyWithImpl(this._self, this._then);

  final _HymnBookmark _self;
  final $Res Function(_HymnBookmark) _then;

/// Create a copy of HymnBookmark
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? hymnCollectionId = null,}) {
  return _then(_HymnBookmark(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,hymnCollectionId: null == hymnCollectionId ? _self.hymnCollectionId : hymnCollectionId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
