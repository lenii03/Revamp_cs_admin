// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cs_logs_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CsLogsState {

 CsLogsStatus get status; List<CsLog> get logs; String get loginId; String get targetId; int get logType; int get page; int get pageSize; String get errorMessage;
/// Create a copy of CsLogsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CsLogsStateCopyWith<CsLogsState> get copyWith => _$CsLogsStateCopyWithImpl<CsLogsState>(this as CsLogsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CsLogsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.logs, logs)&&(identical(other.loginId, loginId) || other.loginId == loginId)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.logType, logType) || other.logType == logType)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(logs),loginId,targetId,logType,page,pageSize,errorMessage);

@override
String toString() {
  return 'CsLogsState(status: $status, logs: $logs, loginId: $loginId, targetId: $targetId, logType: $logType, page: $page, pageSize: $pageSize, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $CsLogsStateCopyWith<$Res>  {
  factory $CsLogsStateCopyWith(CsLogsState value, $Res Function(CsLogsState) _then) = _$CsLogsStateCopyWithImpl;
@useResult
$Res call({
 CsLogsStatus status, List<CsLog> logs, String loginId, String targetId, int logType, int page, int pageSize, String errorMessage
});




}
/// @nodoc
class _$CsLogsStateCopyWithImpl<$Res>
    implements $CsLogsStateCopyWith<$Res> {
  _$CsLogsStateCopyWithImpl(this._self, this._then);

  final CsLogsState _self;
  final $Res Function(CsLogsState) _then;

/// Create a copy of CsLogsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? logs = null,Object? loginId = null,Object? targetId = null,Object? logType = null,Object? page = null,Object? pageSize = null,Object? errorMessage = null,}) {
  return _then(CsLogsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CsLogsStatus,logs: null == logs ? _self.logs : logs // ignore: cast_nullable_to_non_nullable
as List<CsLog>,loginId: null == loginId ? _self.loginId : loginId // ignore: cast_nullable_to_non_nullable
as String,targetId: null == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String,logType: null == logType ? _self.logType : logType // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CsLogsState].
extension CsLogsStatePatterns on CsLogsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CsLogsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CsLogsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CsLogsState value)  $default,){
final _that = this;
switch (_that) {
case _CsLogsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CsLogsState value)?  $default,){
final _that = this;
switch (_that) {
case _CsLogsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CsLogsStatus status,  List<CsLog> logs,  String loginId,  String targetId,  int logType,  int page,  int pageSize,  String errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CsLogsState() when $default != null:
return $default(_that.status,_that.logs,_that.loginId,_that.targetId,_that.logType,_that.page,_that.pageSize,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CsLogsStatus status,  List<CsLog> logs,  String loginId,  String targetId,  int logType,  int page,  int pageSize,  String errorMessage)  $default,) {final _that = this;
switch (_that) {
case _CsLogsState():
return $default(_that.status,_that.logs,_that.loginId,_that.targetId,_that.logType,_that.page,_that.pageSize,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CsLogsStatus status,  List<CsLog> logs,  String loginId,  String targetId,  int logType,  int page,  int pageSize,  String errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _CsLogsState() when $default != null:
return $default(_that.status,_that.logs,_that.loginId,_that.targetId,_that.logType,_that.page,_that.pageSize,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CsLogsState extends CsLogsState {
  const _CsLogsState({this.status = CsLogsStatus.initial,  List<CsLog> logs = const <CsLog>[], this.loginId = '', this.targetId = '', this.logType = -1, this.page = 1, this.pageSize = 30, this.errorMessage = ''}): _logs = logs,super._();
  

@override@JsonKey() final  CsLogsStatus status;
 final  List<CsLog> _logs;
@override@JsonKey() List<CsLog> get logs {
  if (_logs is EqualUnmodifiableListView) return _logs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_logs);
}

@override@JsonKey() final  String loginId;
@override@JsonKey() final  String targetId;
@override@JsonKey() final  int logType;
@override@JsonKey() final  int page;
@override@JsonKey() final  int pageSize;
@override@JsonKey() final  String errorMessage;

/// Create a copy of CsLogsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CsLogsStateCopyWith<_CsLogsState> get copyWith => __$CsLogsStateCopyWithImpl<_CsLogsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CsLogsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._logs, _logs)&&(identical(other.loginId, loginId) || other.loginId == loginId)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.logType, logType) || other.logType == logType)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_logs),loginId,targetId,logType,page,pageSize,errorMessage);

@override
String toString() {
  return 'CsLogsState(status: $status, logs: $logs, loginId: $loginId, targetId: $targetId, logType: $logType, page: $page, pageSize: $pageSize, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$CsLogsStateCopyWith<$Res> implements $CsLogsStateCopyWith<$Res> {
  factory _$CsLogsStateCopyWith(_CsLogsState value, $Res Function(_CsLogsState) _then) = __$CsLogsStateCopyWithImpl;
@override @useResult
$Res call({
 CsLogsStatus status, List<CsLog> logs, String loginId, String targetId, int logType, int page, int pageSize, String errorMessage
});




}
/// @nodoc
class __$CsLogsStateCopyWithImpl<$Res>
    implements _$CsLogsStateCopyWith<$Res> {
  __$CsLogsStateCopyWithImpl(this._self, this._then);

  final _CsLogsState _self;
  final $Res Function(_CsLogsState) _then;

/// Create a copy of CsLogsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? logs = null,Object? loginId = null,Object? targetId = null,Object? logType = null,Object? page = null,Object? pageSize = null,Object? errorMessage = null,}) {
  return _then(_CsLogsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CsLogsStatus,logs: null == logs ? _self._logs : logs // ignore: cast_nullable_to_non_nullable
as List<CsLog>,loginId: null == loginId ? _self.loginId : loginId // ignore: cast_nullable_to_non_nullable
as String,targetId: null == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String,logType: null == logType ? _self.logType : logType // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
