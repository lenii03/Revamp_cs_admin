// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'online_id_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnlineIdEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnlineIdEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnlineIdEvent()';
}


}

/// @nodoc
class $OnlineIdEventCopyWith<$Res>  {
$OnlineIdEventCopyWith(OnlineIdEvent _, $Res Function(OnlineIdEvent) __);
}


/// Adds pattern-matching-related methods to [OnlineIdEvent].
extension OnlineIdEventPatterns on OnlineIdEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _FetchOnlineIds value)?  fetchOnlineIds,TResult Function( _AddOnlineId value)?  addOnlineId,TResult Function( _EditOnlineId value)?  editOnlineId,TResult Function( _DeleteOnlineId value)?  deleteOnlineId,TResult Function( _ResetOnlineId value)?  resetOnlineId,TResult Function( _SelectOnlineId value)?  selectOnlineId,TResult Function( _SearchOnlineIds value)?  searchOnlineIds,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FetchOnlineIds() when fetchOnlineIds != null:
return fetchOnlineIds(_that);case _AddOnlineId() when addOnlineId != null:
return addOnlineId(_that);case _EditOnlineId() when editOnlineId != null:
return editOnlineId(_that);case _DeleteOnlineId() when deleteOnlineId != null:
return deleteOnlineId(_that);case _ResetOnlineId() when resetOnlineId != null:
return resetOnlineId(_that);case _SelectOnlineId() when selectOnlineId != null:
return selectOnlineId(_that);case _SearchOnlineIds() when searchOnlineIds != null:
return searchOnlineIds(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _FetchOnlineIds value)  fetchOnlineIds,required TResult Function( _AddOnlineId value)  addOnlineId,required TResult Function( _EditOnlineId value)  editOnlineId,required TResult Function( _DeleteOnlineId value)  deleteOnlineId,required TResult Function( _ResetOnlineId value)  resetOnlineId,required TResult Function( _SelectOnlineId value)  selectOnlineId,required TResult Function( _SearchOnlineIds value)  searchOnlineIds,}){
final _that = this;
switch (_that) {
case _FetchOnlineIds():
return fetchOnlineIds(_that);case _AddOnlineId():
return addOnlineId(_that);case _EditOnlineId():
return editOnlineId(_that);case _DeleteOnlineId():
return deleteOnlineId(_that);case _ResetOnlineId():
return resetOnlineId(_that);case _SelectOnlineId():
return selectOnlineId(_that);case _SearchOnlineIds():
return searchOnlineIds(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _FetchOnlineIds value)?  fetchOnlineIds,TResult? Function( _AddOnlineId value)?  addOnlineId,TResult? Function( _EditOnlineId value)?  editOnlineId,TResult? Function( _DeleteOnlineId value)?  deleteOnlineId,TResult? Function( _ResetOnlineId value)?  resetOnlineId,TResult? Function( _SelectOnlineId value)?  selectOnlineId,TResult? Function( _SearchOnlineIds value)?  searchOnlineIds,}){
final _that = this;
switch (_that) {
case _FetchOnlineIds() when fetchOnlineIds != null:
return fetchOnlineIds(_that);case _AddOnlineId() when addOnlineId != null:
return addOnlineId(_that);case _EditOnlineId() when editOnlineId != null:
return editOnlineId(_that);case _DeleteOnlineId() when deleteOnlineId != null:
return deleteOnlineId(_that);case _ResetOnlineId() when resetOnlineId != null:
return resetOnlineId(_that);case _SelectOnlineId() when selectOnlineId != null:
return selectOnlineId(_that);case _SearchOnlineIds() when searchOnlineIds != null:
return searchOnlineIds(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  fetchOnlineIds,TResult Function( Map<String, dynamic> data)?  addOnlineId,TResult Function( Map<String, dynamic> data)?  editOnlineId,TResult Function( String loginId)?  deleteOnlineId,TResult Function( String loginId,  String resetType)?  resetOnlineId,TResult Function( OnlineIdModel selectedUser)?  selectOnlineId,TResult Function( String query)?  searchOnlineIds,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FetchOnlineIds() when fetchOnlineIds != null:
return fetchOnlineIds();case _AddOnlineId() when addOnlineId != null:
return addOnlineId(_that.data);case _EditOnlineId() when editOnlineId != null:
return editOnlineId(_that.data);case _DeleteOnlineId() when deleteOnlineId != null:
return deleteOnlineId(_that.loginId);case _ResetOnlineId() when resetOnlineId != null:
return resetOnlineId(_that.loginId,_that.resetType);case _SelectOnlineId() when selectOnlineId != null:
return selectOnlineId(_that.selectedUser);case _SearchOnlineIds() when searchOnlineIds != null:
return searchOnlineIds(_that.query);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  fetchOnlineIds,required TResult Function( Map<String, dynamic> data)  addOnlineId,required TResult Function( Map<String, dynamic> data)  editOnlineId,required TResult Function( String loginId)  deleteOnlineId,required TResult Function( String loginId,  String resetType)  resetOnlineId,required TResult Function( OnlineIdModel selectedUser)  selectOnlineId,required TResult Function( String query)  searchOnlineIds,}) {final _that = this;
switch (_that) {
case _FetchOnlineIds():
return fetchOnlineIds();case _AddOnlineId():
return addOnlineId(_that.data);case _EditOnlineId():
return editOnlineId(_that.data);case _DeleteOnlineId():
return deleteOnlineId(_that.loginId);case _ResetOnlineId():
return resetOnlineId(_that.loginId,_that.resetType);case _SelectOnlineId():
return selectOnlineId(_that.selectedUser);case _SearchOnlineIds():
return searchOnlineIds(_that.query);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  fetchOnlineIds,TResult? Function( Map<String, dynamic> data)?  addOnlineId,TResult? Function( Map<String, dynamic> data)?  editOnlineId,TResult? Function( String loginId)?  deleteOnlineId,TResult? Function( String loginId,  String resetType)?  resetOnlineId,TResult? Function( OnlineIdModel selectedUser)?  selectOnlineId,TResult? Function( String query)?  searchOnlineIds,}) {final _that = this;
switch (_that) {
case _FetchOnlineIds() when fetchOnlineIds != null:
return fetchOnlineIds();case _AddOnlineId() when addOnlineId != null:
return addOnlineId(_that.data);case _EditOnlineId() when editOnlineId != null:
return editOnlineId(_that.data);case _DeleteOnlineId() when deleteOnlineId != null:
return deleteOnlineId(_that.loginId);case _ResetOnlineId() when resetOnlineId != null:
return resetOnlineId(_that.loginId,_that.resetType);case _SelectOnlineId() when selectOnlineId != null:
return selectOnlineId(_that.selectedUser);case _SearchOnlineIds() when searchOnlineIds != null:
return searchOnlineIds(_that.query);case _:
  return null;

}
}

}

/// @nodoc


class _FetchOnlineIds implements OnlineIdEvent {
  const _FetchOnlineIds();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchOnlineIds);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnlineIdEvent.fetchOnlineIds()';
}


}




/// @nodoc


class _AddOnlineId implements OnlineIdEvent {
  const _AddOnlineId( Map<String, dynamic> data): _data = data;
  

 final  Map<String, dynamic> _data;
 Map<String, dynamic> get data {
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_data);
}


/// Create a copy of OnlineIdEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddOnlineIdCopyWith<_AddOnlineId> get copyWith => __$AddOnlineIdCopyWithImpl<_AddOnlineId>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddOnlineId&&const DeepCollectionEquality().equals(other._data, _data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'OnlineIdEvent.addOnlineId(data: $data)';
}


}

/// @nodoc
abstract mixin class _$AddOnlineIdCopyWith<$Res> implements $OnlineIdEventCopyWith<$Res> {
  factory _$AddOnlineIdCopyWith(_AddOnlineId value, $Res Function(_AddOnlineId) _then) = __$AddOnlineIdCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> data
});




}
/// @nodoc
class __$AddOnlineIdCopyWithImpl<$Res>
    implements _$AddOnlineIdCopyWith<$Res> {
  __$AddOnlineIdCopyWithImpl(this._self, this._then);

  final _AddOnlineId _self;
  final $Res Function(_AddOnlineId) _then;

/// Create a copy of OnlineIdEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_AddOnlineId(
null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

/// @nodoc


class _EditOnlineId implements OnlineIdEvent {
  const _EditOnlineId( Map<String, dynamic> data): _data = data;
  

 final  Map<String, dynamic> _data;
 Map<String, dynamic> get data {
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_data);
}


/// Create a copy of OnlineIdEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditOnlineIdCopyWith<_EditOnlineId> get copyWith => __$EditOnlineIdCopyWithImpl<_EditOnlineId>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditOnlineId&&const DeepCollectionEquality().equals(other._data, _data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'OnlineIdEvent.editOnlineId(data: $data)';
}


}

/// @nodoc
abstract mixin class _$EditOnlineIdCopyWith<$Res> implements $OnlineIdEventCopyWith<$Res> {
  factory _$EditOnlineIdCopyWith(_EditOnlineId value, $Res Function(_EditOnlineId) _then) = __$EditOnlineIdCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> data
});




}
/// @nodoc
class __$EditOnlineIdCopyWithImpl<$Res>
    implements _$EditOnlineIdCopyWith<$Res> {
  __$EditOnlineIdCopyWithImpl(this._self, this._then);

  final _EditOnlineId _self;
  final $Res Function(_EditOnlineId) _then;

/// Create a copy of OnlineIdEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_EditOnlineId(
null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

/// @nodoc


class _DeleteOnlineId implements OnlineIdEvent {
  const _DeleteOnlineId(this.loginId);
  

 final  String loginId;

/// Create a copy of OnlineIdEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteOnlineIdCopyWith<_DeleteOnlineId> get copyWith => __$DeleteOnlineIdCopyWithImpl<_DeleteOnlineId>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteOnlineId&&(identical(other.loginId, loginId) || other.loginId == loginId));
}


@override
int get hashCode => Object.hash(runtimeType,loginId);

@override
String toString() {
  return 'OnlineIdEvent.deleteOnlineId(loginId: $loginId)';
}


}

/// @nodoc
abstract mixin class _$DeleteOnlineIdCopyWith<$Res> implements $OnlineIdEventCopyWith<$Res> {
  factory _$DeleteOnlineIdCopyWith(_DeleteOnlineId value, $Res Function(_DeleteOnlineId) _then) = __$DeleteOnlineIdCopyWithImpl;
@useResult
$Res call({
 String loginId
});




}
/// @nodoc
class __$DeleteOnlineIdCopyWithImpl<$Res>
    implements _$DeleteOnlineIdCopyWith<$Res> {
  __$DeleteOnlineIdCopyWithImpl(this._self, this._then);

  final _DeleteOnlineId _self;
  final $Res Function(_DeleteOnlineId) _then;

/// Create a copy of OnlineIdEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? loginId = null,}) {
  return _then(_DeleteOnlineId(
null == loginId ? _self.loginId : loginId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ResetOnlineId implements OnlineIdEvent {
  const _ResetOnlineId({required this.loginId, required this.resetType});
  

 final  String loginId;
 final  String resetType;

/// Create a copy of OnlineIdEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResetOnlineIdCopyWith<_ResetOnlineId> get copyWith => __$ResetOnlineIdCopyWithImpl<_ResetOnlineId>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetOnlineId&&(identical(other.loginId, loginId) || other.loginId == loginId)&&(identical(other.resetType, resetType) || other.resetType == resetType));
}


@override
int get hashCode => Object.hash(runtimeType,loginId,resetType);

@override
String toString() {
  return 'OnlineIdEvent.resetOnlineId(loginId: $loginId, resetType: $resetType)';
}


}

/// @nodoc
abstract mixin class _$ResetOnlineIdCopyWith<$Res> implements $OnlineIdEventCopyWith<$Res> {
  factory _$ResetOnlineIdCopyWith(_ResetOnlineId value, $Res Function(_ResetOnlineId) _then) = __$ResetOnlineIdCopyWithImpl;
@useResult
$Res call({
 String loginId, String resetType
});




}
/// @nodoc
class __$ResetOnlineIdCopyWithImpl<$Res>
    implements _$ResetOnlineIdCopyWith<$Res> {
  __$ResetOnlineIdCopyWithImpl(this._self, this._then);

  final _ResetOnlineId _self;
  final $Res Function(_ResetOnlineId) _then;

/// Create a copy of OnlineIdEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? loginId = null,Object? resetType = null,}) {
  return _then(_ResetOnlineId(
loginId: null == loginId ? _self.loginId : loginId // ignore: cast_nullable_to_non_nullable
as String,resetType: null == resetType ? _self.resetType : resetType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SelectOnlineId implements OnlineIdEvent {
  const _SelectOnlineId(this.selectedUser);
  

 final  OnlineIdModel selectedUser;

/// Create a copy of OnlineIdEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectOnlineIdCopyWith<_SelectOnlineId> get copyWith => __$SelectOnlineIdCopyWithImpl<_SelectOnlineId>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectOnlineId&&(identical(other.selectedUser, selectedUser) || other.selectedUser == selectedUser));
}


@override
int get hashCode => Object.hash(runtimeType,selectedUser);

@override
String toString() {
  return 'OnlineIdEvent.selectOnlineId(selectedUser: $selectedUser)';
}


}

/// @nodoc
abstract mixin class _$SelectOnlineIdCopyWith<$Res> implements $OnlineIdEventCopyWith<$Res> {
  factory _$SelectOnlineIdCopyWith(_SelectOnlineId value, $Res Function(_SelectOnlineId) _then) = __$SelectOnlineIdCopyWithImpl;
@useResult
$Res call({
 OnlineIdModel selectedUser
});




}
/// @nodoc
class __$SelectOnlineIdCopyWithImpl<$Res>
    implements _$SelectOnlineIdCopyWith<$Res> {
  __$SelectOnlineIdCopyWithImpl(this._self, this._then);

  final _SelectOnlineId _self;
  final $Res Function(_SelectOnlineId) _then;

/// Create a copy of OnlineIdEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? selectedUser = null,}) {
  return _then(_SelectOnlineId(
null == selectedUser ? _self.selectedUser : selectedUser // ignore: cast_nullable_to_non_nullable
as OnlineIdModel,
  ));
}


}

/// @nodoc


class _SearchOnlineIds implements OnlineIdEvent {
  const _SearchOnlineIds(this.query);
  

 final  String query;

/// Create a copy of OnlineIdEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchOnlineIdsCopyWith<_SearchOnlineIds> get copyWith => __$SearchOnlineIdsCopyWithImpl<_SearchOnlineIds>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchOnlineIds&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'OnlineIdEvent.searchOnlineIds(query: $query)';
}


}

/// @nodoc
abstract mixin class _$SearchOnlineIdsCopyWith<$Res> implements $OnlineIdEventCopyWith<$Res> {
  factory _$SearchOnlineIdsCopyWith(_SearchOnlineIds value, $Res Function(_SearchOnlineIds) _then) = __$SearchOnlineIdsCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$SearchOnlineIdsCopyWithImpl<$Res>
    implements _$SearchOnlineIdsCopyWith<$Res> {
  __$SearchOnlineIdsCopyWithImpl(this._self, this._then);

  final _SearchOnlineIds _self;
  final $Res Function(_SearchOnlineIds) _then;

/// Create a copy of OnlineIdEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_SearchOnlineIds(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
