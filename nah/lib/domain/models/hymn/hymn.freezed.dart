// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hymn.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Hymn {

// Each hymn has a designated id as it appears in the numbering of a hymnal
 int get id;// Hymn title indicates the title of the hymn as it appears in the hymnal
 String get title;// Each hymn has other details including
// Its ID common hymnal e.g. NEH, CHC, RB; from where they were translated
 Map<String, dynamic> get details;// These are the verses and chorus of the hymns
 Map<String, dynamic> get lyrics;
/// Create a copy of Hymn
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HymnCopyWith<Hymn> get copyWith => _$HymnCopyWithImpl<Hymn>(this as Hymn, _$identity);

  /// Serializes this Hymn to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Hymn&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.details, details)&&const DeepCollectionEquality().equals(other.lyrics, lyrics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(details),const DeepCollectionEquality().hash(lyrics));

@override
String toString() {
  return 'Hymn(id: $id, title: $title, details: $details, lyrics: $lyrics)';
}


}

/// @nodoc
abstract mixin class $HymnCopyWith<$Res>  {
  factory $HymnCopyWith(Hymn value, $Res Function(Hymn) _then) = _$HymnCopyWithImpl;
@useResult
$Res call({
 int id, String title, Map<String, dynamic> details, Map<String, dynamic> lyrics
});




}
/// @nodoc
class _$HymnCopyWithImpl<$Res>
    implements $HymnCopyWith<$Res> {
  _$HymnCopyWithImpl(this._self, this._then);

  final Hymn _self;
  final $Res Function(Hymn) _then;

/// Create a copy of Hymn
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? details = null,Object? lyrics = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,lyrics: null == lyrics ? _self.lyrics : lyrics // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [Hymn].
extension HymnPatterns on Hymn {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Hymn value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Hymn() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Hymn value)  $default,){
final _that = this;
switch (_that) {
case _Hymn():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Hymn value)?  $default,){
final _that = this;
switch (_that) {
case _Hymn() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  Map<String, dynamic> details,  Map<String, dynamic> lyrics)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Hymn() when $default != null:
return $default(_that.id,_that.title,_that.details,_that.lyrics);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  Map<String, dynamic> details,  Map<String, dynamic> lyrics)  $default,) {final _that = this;
switch (_that) {
case _Hymn():
return $default(_that.id,_that.title,_that.details,_that.lyrics);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  Map<String, dynamic> details,  Map<String, dynamic> lyrics)?  $default,) {final _that = this;
switch (_that) {
case _Hymn() when $default != null:
return $default(_that.id,_that.title,_that.details,_that.lyrics);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Hymn implements Hymn {
  const _Hymn({required this.id, required this.title, required final  Map<String, dynamic> details, required final  Map<String, dynamic> lyrics}): _details = details,_lyrics = lyrics;
  factory _Hymn.fromJson(Map<String, dynamic> json) => _$HymnFromJson(json);

// Each hymn has a designated id as it appears in the numbering of a hymnal
@override final  int id;
// Hymn title indicates the title of the hymn as it appears in the hymnal
@override final  String title;
// Each hymn has other details including
// Its ID common hymnal e.g. NEH, CHC, RB; from where they were translated
 final  Map<String, dynamic> _details;
// Each hymn has other details including
// Its ID common hymnal e.g. NEH, CHC, RB; from where they were translated
@override Map<String, dynamic> get details {
  if (_details is EqualUnmodifiableMapView) return _details;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_details);
}

// These are the verses and chorus of the hymns
 final  Map<String, dynamic> _lyrics;
// These are the verses and chorus of the hymns
@override Map<String, dynamic> get lyrics {
  if (_lyrics is EqualUnmodifiableMapView) return _lyrics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_lyrics);
}


/// Create a copy of Hymn
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HymnCopyWith<_Hymn> get copyWith => __$HymnCopyWithImpl<_Hymn>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HymnToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Hymn&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._details, _details)&&const DeepCollectionEquality().equals(other._lyrics, _lyrics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(_details),const DeepCollectionEquality().hash(_lyrics));

@override
String toString() {
  return 'Hymn(id: $id, title: $title, details: $details, lyrics: $lyrics)';
}


}

/// @nodoc
abstract mixin class _$HymnCopyWith<$Res> implements $HymnCopyWith<$Res> {
  factory _$HymnCopyWith(_Hymn value, $Res Function(_Hymn) _then) = __$HymnCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, Map<String, dynamic> details, Map<String, dynamic> lyrics
});




}
/// @nodoc
class __$HymnCopyWithImpl<$Res>
    implements _$HymnCopyWith<$Res> {
  __$HymnCopyWithImpl(this._self, this._then);

  final _Hymn _self;
  final $Res Function(_Hymn) _then;

/// Create a copy of Hymn
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? details = null,Object? lyrics = null,}) {
  return _then(_Hymn(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,details: null == details ? _self._details : details // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,lyrics: null == lyrics ? _self._lyrics : lyrics // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
