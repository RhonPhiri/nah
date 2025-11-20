// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hymnal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Hymnal {

 int get id; String get title; String get language;
/// Create a copy of Hymnal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HymnalCopyWith<Hymnal> get copyWith => _$HymnalCopyWithImpl<Hymnal>(this as Hymnal, _$identity);

  /// Serializes this Hymnal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Hymnal&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.language, language) || other.language == language));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,language);

@override
String toString() {
  return 'Hymnal(id: $id, title: $title, language: $language)';
}


}

/// @nodoc
abstract mixin class $HymnalCopyWith<$Res>  {
  factory $HymnalCopyWith(Hymnal value, $Res Function(Hymnal) _then) = _$HymnalCopyWithImpl;
@useResult
$Res call({
 int id, String title, String language
});




}
/// @nodoc
class _$HymnalCopyWithImpl<$Res>
    implements $HymnalCopyWith<$Res> {
  _$HymnalCopyWithImpl(this._self, this._then);

  final Hymnal _self;
  final $Res Function(Hymnal) _then;

/// Create a copy of Hymnal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? language = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Hymnal].
extension HymnalPatterns on Hymnal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Hymnal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Hymnal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Hymnal value)  $default,){
final _that = this;
switch (_that) {
case _Hymnal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Hymnal value)?  $default,){
final _that = this;
switch (_that) {
case _Hymnal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String language)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Hymnal() when $default != null:
return $default(_that.id,_that.title,_that.language);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String language)  $default,) {final _that = this;
switch (_that) {
case _Hymnal():
return $default(_that.id,_that.title,_that.language);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String language)?  $default,) {final _that = this;
switch (_that) {
case _Hymnal() when $default != null:
return $default(_that.id,_that.title,_that.language);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Hymnal implements Hymnal {
  const _Hymnal({required this.id, required this.title, required this.language});
  factory _Hymnal.fromJson(Map<String, dynamic> json) => _$HymnalFromJson(json);

@override final  int id;
@override final  String title;
@override final  String language;

/// Create a copy of Hymnal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HymnalCopyWith<_Hymnal> get copyWith => __$HymnalCopyWithImpl<_Hymnal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HymnalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Hymnal&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.language, language) || other.language == language));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,language);

@override
String toString() {
  return 'Hymnal(id: $id, title: $title, language: $language)';
}


}

/// @nodoc
abstract mixin class _$HymnalCopyWith<$Res> implements $HymnalCopyWith<$Res> {
  factory _$HymnalCopyWith(_Hymnal value, $Res Function(_Hymnal) _then) = __$HymnalCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String language
});




}
/// @nodoc
class __$HymnalCopyWithImpl<$Res>
    implements _$HymnalCopyWith<$Res> {
  __$HymnalCopyWithImpl(this._self, this._then);

  final _Hymnal _self;
  final $Res Function(_Hymnal) _then;

/// Create a copy of Hymnal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? language = null,}) {
  return _then(_Hymnal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
