// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationState()';
}


}

/// @nodoc
class $NotificationStateCopyWith<$Res>  {
$NotificationStateCopyWith(NotificationState _, $Res Function(NotificationState) __);
}


/// Adds pattern-matching-related methods to [NotificationState].
extension NotificationStatePatterns on NotificationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NotificationInitial value)?  initial,TResult Function( NotificationLoading value)?  loading,TResult Function( SchedulerLoaded value)?  schedulerLoaded,TResult Function( NotificationActionSuccess value)?  actionSuccess,TResult Function( NotificationError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NotificationInitial() when initial != null:
return initial(_that);case NotificationLoading() when loading != null:
return loading(_that);case SchedulerLoaded() when schedulerLoaded != null:
return schedulerLoaded(_that);case NotificationActionSuccess() when actionSuccess != null:
return actionSuccess(_that);case NotificationError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NotificationInitial value)  initial,required TResult Function( NotificationLoading value)  loading,required TResult Function( SchedulerLoaded value)  schedulerLoaded,required TResult Function( NotificationActionSuccess value)  actionSuccess,required TResult Function( NotificationError value)  error,}){
final _that = this;
switch (_that) {
case NotificationInitial():
return initial(_that);case NotificationLoading():
return loading(_that);case SchedulerLoaded():
return schedulerLoaded(_that);case NotificationActionSuccess():
return actionSuccess(_that);case NotificationError():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NotificationInitial value)?  initial,TResult? Function( NotificationLoading value)?  loading,TResult? Function( SchedulerLoaded value)?  schedulerLoaded,TResult? Function( NotificationActionSuccess value)?  actionSuccess,TResult? Function( NotificationError value)?  error,}){
final _that = this;
switch (_that) {
case NotificationInitial() when initial != null:
return initial(_that);case NotificationLoading() when loading != null:
return loading(_that);case SchedulerLoaded() when schedulerLoaded != null:
return schedulerLoaded(_that);case NotificationActionSuccess() when actionSuccess != null:
return actionSuccess(_that);case NotificationError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<NotificationModel> data)?  schedulerLoaded,TResult Function( String message)?  actionSuccess,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NotificationInitial() when initial != null:
return initial();case NotificationLoading() when loading != null:
return loading();case SchedulerLoaded() when schedulerLoaded != null:
return schedulerLoaded(_that.data);case NotificationActionSuccess() when actionSuccess != null:
return actionSuccess(_that.message);case NotificationError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<NotificationModel> data)  schedulerLoaded,required TResult Function( String message)  actionSuccess,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case NotificationInitial():
return initial();case NotificationLoading():
return loading();case SchedulerLoaded():
return schedulerLoaded(_that.data);case NotificationActionSuccess():
return actionSuccess(_that.message);case NotificationError():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<NotificationModel> data)?  schedulerLoaded,TResult? Function( String message)?  actionSuccess,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case NotificationInitial() when initial != null:
return initial();case NotificationLoading() when loading != null:
return loading();case SchedulerLoaded() when schedulerLoaded != null:
return schedulerLoaded(_that.data);case NotificationActionSuccess() when actionSuccess != null:
return actionSuccess(_that.message);case NotificationError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class NotificationInitial implements NotificationState {
  const NotificationInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationState.initial()';
}


}




/// @nodoc


class NotificationLoading implements NotificationState {
  const NotificationLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationState.loading()';
}


}




/// @nodoc


class SchedulerLoaded implements NotificationState {
  const SchedulerLoaded( List<NotificationModel> data): _data = data;
  

 final  List<NotificationModel> _data;
 List<NotificationModel> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}


/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SchedulerLoadedCopyWith<SchedulerLoaded> get copyWith => _$SchedulerLoadedCopyWithImpl<SchedulerLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SchedulerLoaded&&const DeepCollectionEquality().equals(other._data, _data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'NotificationState.schedulerLoaded(data: $data)';
}


}

/// @nodoc
abstract mixin class $SchedulerLoadedCopyWith<$Res> implements $NotificationStateCopyWith<$Res> {
  factory $SchedulerLoadedCopyWith(SchedulerLoaded value, $Res Function(SchedulerLoaded) _then) = _$SchedulerLoadedCopyWithImpl;
@useResult
$Res call({
 List<NotificationModel> data
});




}
/// @nodoc
class _$SchedulerLoadedCopyWithImpl<$Res>
    implements $SchedulerLoadedCopyWith<$Res> {
  _$SchedulerLoadedCopyWithImpl(this._self, this._then);

  final SchedulerLoaded _self;
  final $Res Function(SchedulerLoaded) _then;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(SchedulerLoaded(
null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<NotificationModel>,
  ));
}


}

/// @nodoc


class NotificationActionSuccess implements NotificationState {
  const NotificationActionSuccess(this.message);
  

 final  String message;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationActionSuccessCopyWith<NotificationActionSuccess> get copyWith => _$NotificationActionSuccessCopyWithImpl<NotificationActionSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationActionSuccess&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'NotificationState.actionSuccess(message: $message)';
}


}

/// @nodoc
abstract mixin class $NotificationActionSuccessCopyWith<$Res> implements $NotificationStateCopyWith<$Res> {
  factory $NotificationActionSuccessCopyWith(NotificationActionSuccess value, $Res Function(NotificationActionSuccess) _then) = _$NotificationActionSuccessCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$NotificationActionSuccessCopyWithImpl<$Res>
    implements $NotificationActionSuccessCopyWith<$Res> {
  _$NotificationActionSuccessCopyWithImpl(this._self, this._then);

  final NotificationActionSuccess _self;
  final $Res Function(NotificationActionSuccess) _then;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(NotificationActionSuccess(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class NotificationError implements NotificationState {
  const NotificationError(this.message);
  

 final  String message;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationErrorCopyWith<NotificationError> get copyWith => _$NotificationErrorCopyWithImpl<NotificationError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'NotificationState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $NotificationErrorCopyWith<$Res> implements $NotificationStateCopyWith<$Res> {
  factory $NotificationErrorCopyWith(NotificationError value, $Res Function(NotificationError) _then) = _$NotificationErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$NotificationErrorCopyWithImpl<$Res>
    implements $NotificationErrorCopyWith<$Res> {
  _$NotificationErrorCopyWithImpl(this._self, this._then);

  final NotificationError _self;
  final $Res Function(NotificationError) _then;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(NotificationError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
