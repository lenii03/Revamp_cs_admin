// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manage_cs_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ManageCsState {

 ManageCsStatus get status; List<ManageCsUser> get allUsers; List<ManageCsUser> get csUsers; String get query; int get page; int get pageSize; String get errorMessage;
/// Create a copy of ManageCsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ManageCsStateCopyWith<ManageCsState> get copyWith => _$ManageCsStateCopyWithImpl<ManageCsState>(this as ManageCsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ManageCsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.allUsers, allUsers)&&const DeepCollectionEquality().equals(other.csUsers, csUsers)&&(identical(other.query, query) || other.query == query)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(allUsers),const DeepCollectionEquality().hash(csUsers),query,page,pageSize,errorMessage);

@override
String toString() {
  return 'ManageCsState(status: $status, allUsers: $allUsers, csUsers: $csUsers, query: $query, page: $page, pageSize: $pageSize, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ManageCsStateCopyWith<$Res>  {
  factory $ManageCsStateCopyWith(ManageCsState value, $Res Function(ManageCsState) _then) = _$ManageCsStateCopyWithImpl;
@useResult
$Res call({
 ManageCsStatus status, List<ManageCsUser> allUsers, List<ManageCsUser> csUsers, String query, int page, int pageSize, String errorMessage
});




}
/// @nodoc
class _$ManageCsStateCopyWithImpl<$Res>
    implements $ManageCsStateCopyWith<$Res> {
  _$ManageCsStateCopyWithImpl(this._self, this._then);

  final ManageCsState _self;
  final $Res Function(ManageCsState) _then;

/// Create a copy of ManageCsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? allUsers = null,Object? csUsers = null,Object? query = null,Object? page = null,Object? pageSize = null,Object? errorMessage = null,}) {
  return _then(ManageCsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ManageCsStatus,allUsers: null == allUsers ? _self.allUsers : allUsers // ignore: cast_nullable_to_non_nullable
as List<ManageCsUser>,csUsers: null == csUsers ? _self.csUsers : csUsers // ignore: cast_nullable_to_non_nullable
as List<ManageCsUser>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ManageCsState].
extension ManageCsStatePatterns on ManageCsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ManageCsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ManageCsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ManageCsState value)  $default,){
final _that = this;
switch (_that) {
case _ManageCsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ManageCsState value)?  $default,){
final _that = this;
switch (_that) {
case _ManageCsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ManageCsStatus status,  List<ManageCsUser> allUsers,  List<ManageCsUser> csUsers,  String query,  int page,  int pageSize,  String errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ManageCsState() when $default != null:
return $default(_that.status,_that.allUsers,_that.csUsers,_that.query,_that.page,_that.pageSize,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ManageCsStatus status,  List<ManageCsUser> allUsers,  List<ManageCsUser> csUsers,  String query,  int page,  int pageSize,  String errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ManageCsState():
return $default(_that.status,_that.allUsers,_that.csUsers,_that.query,_that.page,_that.pageSize,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ManageCsStatus status,  List<ManageCsUser> allUsers,  List<ManageCsUser> csUsers,  String query,  int page,  int pageSize,  String errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ManageCsState() when $default != null:
return $default(_that.status,_that.allUsers,_that.csUsers,_that.query,_that.page,_that.pageSize,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ManageCsState extends ManageCsState {
  const _ManageCsState({this.status = ManageCsStatus.initial,  List<ManageCsUser> allUsers = const <ManageCsUser>[],  List<ManageCsUser> csUsers = const <ManageCsUser>[], this.query = '', this.page = 1, this.pageSize = 30, this.errorMessage = ''}): _allUsers = allUsers,_csUsers = csUsers,super._();
  

@override@JsonKey() final  ManageCsStatus status;
 final  List<ManageCsUser> _allUsers;
@override@JsonKey() List<ManageCsUser> get allUsers {
  if (_allUsers is EqualUnmodifiableListView) return _allUsers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allUsers);
}

 final  List<ManageCsUser> _csUsers;
@override@JsonKey() List<ManageCsUser> get csUsers {
  if (_csUsers is EqualUnmodifiableListView) return _csUsers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_csUsers);
}

@override@JsonKey() final  String query;
@override@JsonKey() final  int page;
@override@JsonKey() final  int pageSize;
@override@JsonKey() final  String errorMessage;

/// Create a copy of ManageCsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ManageCsStateCopyWith<_ManageCsState> get copyWith => __$ManageCsStateCopyWithImpl<_ManageCsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ManageCsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._allUsers, _allUsers)&&const DeepCollectionEquality().equals(other._csUsers, _csUsers)&&(identical(other.query, query) || other.query == query)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_allUsers),const DeepCollectionEquality().hash(_csUsers),query,page,pageSize,errorMessage);

@override
String toString() {
  return 'ManageCsState(status: $status, allUsers: $allUsers, csUsers: $csUsers, query: $query, page: $page, pageSize: $pageSize, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ManageCsStateCopyWith<$Res> implements $ManageCsStateCopyWith<$Res> {
  factory _$ManageCsStateCopyWith(_ManageCsState value, $Res Function(_ManageCsState) _then) = __$ManageCsStateCopyWithImpl;
@override @useResult
$Res call({
 ManageCsStatus status, List<ManageCsUser> allUsers, List<ManageCsUser> csUsers, String query, int page, int pageSize, String errorMessage
});




}
/// @nodoc
class __$ManageCsStateCopyWithImpl<$Res>
    implements _$ManageCsStateCopyWith<$Res> {
  __$ManageCsStateCopyWithImpl(this._self, this._then);

  final _ManageCsState _self;
  final $Res Function(_ManageCsState) _then;

/// Create a copy of ManageCsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? allUsers = null,Object? csUsers = null,Object? query = null,Object? page = null,Object? pageSize = null,Object? errorMessage = null,}) {
  return _then(_ManageCsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ManageCsStatus,allUsers: null == allUsers ? _self._allUsers : allUsers // ignore: cast_nullable_to_non_nullable
as List<ManageCsUser>,csUsers: null == csUsers ? _self._csUsers : csUsers // ignore: cast_nullable_to_non_nullable
as List<ManageCsUser>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
