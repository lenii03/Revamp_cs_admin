// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_email_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SendEmailForgotState {

 SendEmailForgotStatus get status; List<SendEmailForgotModel> get dataList; String get message;
/// Create a copy of SendEmailForgotState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendEmailForgotStateCopyWith<SendEmailForgotState> get copyWith => _$SendEmailForgotStateCopyWithImpl<SendEmailForgotState>(this as SendEmailForgotState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendEmailForgotState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.dataList, dataList)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(dataList),message);

@override
String toString() {
  return 'SendEmailForgotState(status: $status, dataList: $dataList, message: $message)';
}


}

/// @nodoc
abstract mixin class $SendEmailForgotStateCopyWith<$Res>  {
  factory $SendEmailForgotStateCopyWith(SendEmailForgotState value, $Res Function(SendEmailForgotState) _then) = _$SendEmailForgotStateCopyWithImpl;
@useResult
$Res call({
 SendEmailForgotStatus status, List<SendEmailForgotModel> dataList, String message
});




}
/// @nodoc
class _$SendEmailForgotStateCopyWithImpl<$Res>
    implements $SendEmailForgotStateCopyWith<$Res> {
  _$SendEmailForgotStateCopyWithImpl(this._self, this._then);

  final SendEmailForgotState _self;
  final $Res Function(SendEmailForgotState) _then;

/// Create a copy of SendEmailForgotState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? dataList = null,Object? message = null,}) {
  return _then(SendEmailForgotState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SendEmailForgotStatus,dataList: null == dataList ? _self.dataList : dataList // ignore: cast_nullable_to_non_nullable
as List<SendEmailForgotModel>,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SendEmailForgotState].
extension SendEmailForgotStatePatterns on SendEmailForgotState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SendEmailForgotState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SendEmailForgotState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SendEmailForgotState value)  $default,){
final _that = this;
switch (_that) {
case _SendEmailForgotState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SendEmailForgotState value)?  $default,){
final _that = this;
switch (_that) {
case _SendEmailForgotState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SendEmailForgotStatus status,  List<SendEmailForgotModel> dataList,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SendEmailForgotState() when $default != null:
return $default(_that.status,_that.dataList,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SendEmailForgotStatus status,  List<SendEmailForgotModel> dataList,  String message)  $default,) {final _that = this;
switch (_that) {
case _SendEmailForgotState():
return $default(_that.status,_that.dataList,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SendEmailForgotStatus status,  List<SendEmailForgotModel> dataList,  String message)?  $default,) {final _that = this;
switch (_that) {
case _SendEmailForgotState() when $default != null:
return $default(_that.status,_that.dataList,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _SendEmailForgotState implements SendEmailForgotState {
  const _SendEmailForgotState({this.status = SendEmailForgotStatus.initial,  List<SendEmailForgotModel> dataList = const <SendEmailForgotModel>[], this.message = ''}): _dataList = dataList;
  

@override@JsonKey() final  SendEmailForgotStatus status;
 final  List<SendEmailForgotModel> _dataList;
@override@JsonKey() List<SendEmailForgotModel> get dataList {
  if (_dataList is EqualUnmodifiableListView) return _dataList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dataList);
}

@override@JsonKey() final  String message;

/// Create a copy of SendEmailForgotState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendEmailForgotStateCopyWith<_SendEmailForgotState> get copyWith => __$SendEmailForgotStateCopyWithImpl<_SendEmailForgotState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendEmailForgotState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._dataList, _dataList)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_dataList),message);

@override
String toString() {
  return 'SendEmailForgotState(status: $status, dataList: $dataList, message: $message)';
}


}

/// @nodoc
abstract mixin class _$SendEmailForgotStateCopyWith<$Res> implements $SendEmailForgotStateCopyWith<$Res> {
  factory _$SendEmailForgotStateCopyWith(_SendEmailForgotState value, $Res Function(_SendEmailForgotState) _then) = __$SendEmailForgotStateCopyWithImpl;
@override @useResult
$Res call({
 SendEmailForgotStatus status, List<SendEmailForgotModel> dataList, String message
});




}
/// @nodoc
class __$SendEmailForgotStateCopyWithImpl<$Res>
    implements _$SendEmailForgotStateCopyWith<$Res> {
  __$SendEmailForgotStateCopyWithImpl(this._self, this._then);

  final _SendEmailForgotState _self;
  final $Res Function(_SendEmailForgotState) _then;

/// Create a copy of SendEmailForgotState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? dataList = null,Object? message = null,}) {
  return _then(_SendEmailForgotState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SendEmailForgotStatus,dataList: null == dataList ? _self._dataList : dataList // ignore: cast_nullable_to_non_nullable
as List<SendEmailForgotModel>,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
