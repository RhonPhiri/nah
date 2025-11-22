// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hymn_collection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HymnCollection {

// Unique identifier for the hymn collection
 int get id;// Title of the hymn collection
 String get title;// Optional description providing more details about the hymn collection
 String? get description;
/// Create a copy of HymnCollection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HymnCollectionCopyWith<HymnCollection> get copyWith => _$HymnCollectionCopyWithImpl<HymnCollection>(this as HymnCollection, _$identity);

  /// Serializes this HymnCollection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HymnCollection&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description);

@override
String toString() {
  return 'HymnCollection(id: $id, title: $title, description: $description)';
}


}

/// @nodoc
abstract mixin class $HymnCollectionCopyWith<$Res>  {
  factory $HymnCollectionCopyWith(HymnCollection value, $Res Function(HymnCollection) _then) = _$HymnCollectionCopyWithImpl;
@useResult
$Res call({
 int id, String title, String? description
});




}
/// @nodoc
class _$HymnCollectionCopyWithImpl<$Res>
    implements $HymnCollectionCopyWith<$Res> {
  _$HymnCollectionCopyWithImpl(this._self, this._then);

  final HymnCollection _self;
  final $Res Function(HymnCollection) _then;

/// Create a copy of HymnCollection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HymnCollection].
extension HymnCollectionPatterns on HymnCollection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HymnCollection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HymnCollection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HymnCollection value)  $default,){
final _that = this;
switch (_that) {
case _HymnCollection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HymnCollection value)?  $default,){
final _that = this;
switch (_that) {
case _HymnCollection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HymnCollection() when $default != null:
return $default(_that.id,_that.title,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String? description)  $default,) {final _that = this;
switch (_that) {
case _HymnCollection():
return $default(_that.id,_that.title,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _HymnCollection() when $default != null:
return $default(_that.id,_that.title,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HymnCollection implements HymnCollection {
  const _HymnCollection({required this.id, required this.title, this.description});
  factory _HymnCollection.fromJson(Map<String, dynamic> json) => _$HymnCollectionFromJson(json);

// Unique identifier for the hymn collection
@override final  int id;
// Title of the hymn collection
@override final  String title;
// Optional description providing more details about the hymn collection
@override final  String? description;

/// Create a copy of HymnCollection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HymnCollectionCopyWith<_HymnCollection> get copyWith => __$HymnCollectionCopyWithImpl<_HymnCollection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HymnCollectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HymnCollection&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description);

@override
String toString() {
  return 'HymnCollection(id: $id, title: $title, description: $description)';
}


}

/// @nodoc
abstract mixin class _$HymnCollectionCopyWith<$Res> implements $HymnCollectionCopyWith<$Res> {
  factory _$HymnCollectionCopyWith(_HymnCollection value, $Res Function(_HymnCollection) _then) = __$HymnCollectionCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String? description
});




}
/// @nodoc
class __$HymnCollectionCopyWithImpl<$Res>
    implements _$HymnCollectionCopyWith<$Res> {
  __$HymnCollectionCopyWithImpl(this._self, this._then);

  final _HymnCollection _self;
  final $Res Function(_HymnCollection) _then;

/// Create a copy of HymnCollection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,}) {
  return _then(_HymnCollection(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
