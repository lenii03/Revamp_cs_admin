// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'approve_opening_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApproveOpeningState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApproveOpeningState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApproveOpeningState()';
}


}

/// @nodoc
class $ApproveOpeningStateCopyWith<$Res>  {
$ApproveOpeningStateCopyWith(ApproveOpeningState _, $Res Function(ApproveOpeningState) __);
}


/// Adds pattern-matching-related methods to [ApproveOpeningState].
extension ApproveOpeningStatePatterns on ApproveOpeningState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ApproveOpeningInitial value)?  initial,TResult Function( ApproveOpeningLoading value)?  loading,TResult Function( ApproveOpeningLoaded value)?  loaded,TResult Function( ApproveOpeningError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ApproveOpeningInitial() when initial != null:
return initial(_that);case ApproveOpeningLoading() when loading != null:
return loading(_that);case ApproveOpeningLoaded() when loaded != null:
return loaded(_that);case ApproveOpeningError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ApproveOpeningInitial value)  initial,required TResult Function( ApproveOpeningLoading value)  loading,required TResult Function( ApproveOpeningLoaded value)  loaded,required TResult Function( ApproveOpeningError value)  error,}){
final _that = this;
switch (_that) {
case ApproveOpeningInitial():
return initial(_that);case ApproveOpeningLoading():
return loading(_that);case ApproveOpeningLoaded():
return loaded(_that);case ApproveOpeningError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ApproveOpeningInitial value)?  initial,TResult? Function( ApproveOpeningLoading value)?  loading,TResult? Function( ApproveOpeningLoaded value)?  loaded,TResult? Function( ApproveOpeningError value)?  error,}){
final _that = this;
switch (_that) {
case ApproveOpeningInitial() when initial != null:
return initial(_that);case ApproveOpeningLoading() when loading != null:
return loading(_that);case ApproveOpeningLoaded() when loaded != null:
return loaded(_that);case ApproveOpeningError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<ApproveOpeningAccountModel> data,  ApproveOpeningAccountModel? selectedAccount,  bool isSending,  String? notification,  bool notificationIsError)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ApproveOpeningInitial() when initial != null:
return initial();case ApproveOpeningLoading() when loading != null:
return loading();case ApproveOpeningLoaded() when loaded != null:
return loaded(_that.data,_that.selectedAccount,_that.isSending,_that.notification,_that.notificationIsError);case ApproveOpeningError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<ApproveOpeningAccountModel> data,  ApproveOpeningAccountModel? selectedAccount,  bool isSending,  String? notification,  bool notificationIsError)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ApproveOpeningInitial():
return initial();case ApproveOpeningLoading():
return loading();case ApproveOpeningLoaded():
return loaded(_that.data,_that.selectedAccount,_that.isSending,_that.notification,_that.notificationIsError);case ApproveOpeningError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<ApproveOpeningAccountModel> data,  ApproveOpeningAccountModel? selectedAccount,  bool isSending,  String? notification,  bool notificationIsError)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ApproveOpeningInitial() when initial != null:
return initial();case ApproveOpeningLoading() when loading != null:
return loading();case ApproveOpeningLoaded() when loaded != null:
return loaded(_that.data,_that.selectedAccount,_that.isSending,_that.notification,_that.notificationIsError);case ApproveOpeningError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ApproveOpeningInitial implements ApproveOpeningState {
  const ApproveOpeningInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApproveOpeningInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApproveOpeningState.initial()';
}


}




/// @nodoc


class ApproveOpeningLoading implements ApproveOpeningState {
  const ApproveOpeningLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApproveOpeningLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApproveOpeningState.loading()';
}


}




/// @nodoc


class ApproveOpeningLoaded implements ApproveOpeningState {
  const ApproveOpeningLoaded( List<ApproveOpeningAccountModel> data, {this.selectedAccount, this.isSending = false, this.notification, this.notificationIsError = false}): _data = data;
  

 final  List<ApproveOpeningAccountModel> _data;
 List<ApproveOpeningAccountModel> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}

 final  ApproveOpeningAccountModel? selectedAccount;
@JsonKey() final  bool isSending;
 final  String? notification;
@JsonKey() final  bool notificationIsError;

/// Create a copy of ApproveOpeningState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApproveOpeningLoadedCopyWith<ApproveOpeningLoaded> get copyWith => _$ApproveOpeningLoadedCopyWithImpl<ApproveOpeningLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApproveOpeningLoaded&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.selectedAccount, selectedAccount) || other.selectedAccount == selectedAccount)&&(identical(other.isSending, isSending) || other.isSending == isSending)&&(identical(other.notification, notification) || other.notification == notification)&&(identical(other.notificationIsError, notificationIsError) || other.notificationIsError == notificationIsError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data),selectedAccount,isSending,notification,notificationIsError);

@override
String toString() {
  return 'ApproveOpeningState.loaded(data: $data, selectedAccount: $selectedAccount, isSending: $isSending, notification: $notification, notificationIsError: $notificationIsError)';
}


}

/// @nodoc
abstract mixin class $ApproveOpeningLoadedCopyWith<$Res> implements $ApproveOpeningStateCopyWith<$Res> {
  factory $ApproveOpeningLoadedCopyWith(ApproveOpeningLoaded value, $Res Function(ApproveOpeningLoaded) _then) = _$ApproveOpeningLoadedCopyWithImpl;
@useResult
$Res call({
 List<ApproveOpeningAccountModel> data, ApproveOpeningAccountModel? selectedAccount, bool isSending, String? notification, bool notificationIsError
});




}
/// @nodoc
class _$ApproveOpeningLoadedCopyWithImpl<$Res>
    implements $ApproveOpeningLoadedCopyWith<$Res> {
  _$ApproveOpeningLoadedCopyWithImpl(this._self, this._then);

  final ApproveOpeningLoaded _self;
  final $Res Function(ApproveOpeningLoaded) _then;

/// Create a copy of ApproveOpeningState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,Object? selectedAccount = freezed,Object? isSending = null,Object? notification = freezed,Object? notificationIsError = null,}) {
  return _then(ApproveOpeningLoaded(
null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<ApproveOpeningAccountModel>,selectedAccount: freezed == selectedAccount ? _self.selectedAccount : selectedAccount // ignore: cast_nullable_to_non_nullable
as ApproveOpeningAccountModel?,isSending: null == isSending ? _self.isSending : isSending // ignore: cast_nullable_to_non_nullable
as bool,notification: freezed == notification ? _self.notification : notification // ignore: cast_nullable_to_non_nullable
as String?,notificationIsError: null == notificationIsError ? _self.notificationIsError : notificationIsError // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ApproveOpeningError implements ApproveOpeningState {
  const ApproveOpeningError(this.message);
  

 final  String message;

/// Create a copy of ApproveOpeningState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApproveOpeningErrorCopyWith<ApproveOpeningError> get copyWith => _$ApproveOpeningErrorCopyWithImpl<ApproveOpeningError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApproveOpeningError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ApproveOpeningState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ApproveOpeningErrorCopyWith<$Res> implements $ApproveOpeningStateCopyWith<$Res> {
  factory $ApproveOpeningErrorCopyWith(ApproveOpeningError value, $Res Function(ApproveOpeningError) _then) = _$ApproveOpeningErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ApproveOpeningErrorCopyWithImpl<$Res>
    implements $ApproveOpeningErrorCopyWith<$Res> {
  _$ApproveOpeningErrorCopyWithImpl(this._self, this._then);

  final ApproveOpeningError _self;
  final $Res Function(ApproveOpeningError) _then;

/// Create a copy of ApproveOpeningState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ApproveOpeningError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
