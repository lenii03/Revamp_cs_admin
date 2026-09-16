// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DashboardState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardState()';
}


}

/// @nodoc
class $DashboardStateCopyWith<$Res>  {
$DashboardStateCopyWith(DashboardState _, $Res Function(DashboardState) __);
}


/// Adds pattern-matching-related methods to [DashboardState].
extension DashboardStatePatterns on DashboardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DashboardInitial value)?  initial,TResult Function( DashboardLoading value)?  loading,TResult Function( DashboardLoaded value)?  loaded,TResult Function( DashboardError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DashboardInitial() when initial != null:
return initial(_that);case DashboardLoading() when loading != null:
return loading(_that);case DashboardLoaded() when loaded != null:
return loaded(_that);case DashboardError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DashboardInitial value)  initial,required TResult Function( DashboardLoading value)  loading,required TResult Function( DashboardLoaded value)  loaded,required TResult Function( DashboardError value)  error,}){
final _that = this;
switch (_that) {
case DashboardInitial():
return initial(_that);case DashboardLoading():
return loading(_that);case DashboardLoaded():
return loaded(_that);case DashboardError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DashboardInitial value)?  initial,TResult? Function( DashboardLoading value)?  loading,TResult? Function( DashboardLoaded value)?  loaded,TResult? Function( DashboardError value)?  error,}){
final _that = this;
switch (_that) {
case DashboardInitial() when initial != null:
return initial(_that);case DashboardLoading() when loading != null:
return loading(_that);case DashboardLoaded() when loaded != null:
return loaded(_that);case DashboardError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String totalCs,  String totalUserOnline,  String totalPending,  String incompleteCredentials,  List<IncompleteCredential> incompleteCredentialUsers,  Map<String, String> errors)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DashboardInitial() when initial != null:
return initial();case DashboardLoading() when loading != null:
return loading();case DashboardLoaded() when loaded != null:
return loaded(_that.totalCs,_that.totalUserOnline,_that.totalPending,_that.incompleteCredentials,_that.incompleteCredentialUsers,_that.errors);case DashboardError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String totalCs,  String totalUserOnline,  String totalPending,  String incompleteCredentials,  List<IncompleteCredential> incompleteCredentialUsers,  Map<String, String> errors)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case DashboardInitial():
return initial();case DashboardLoading():
return loading();case DashboardLoaded():
return loaded(_that.totalCs,_that.totalUserOnline,_that.totalPending,_that.incompleteCredentials,_that.incompleteCredentialUsers,_that.errors);case DashboardError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String totalCs,  String totalUserOnline,  String totalPending,  String incompleteCredentials,  List<IncompleteCredential> incompleteCredentialUsers,  Map<String, String> errors)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case DashboardInitial() when initial != null:
return initial();case DashboardLoading() when loading != null:
return loading();case DashboardLoaded() when loaded != null:
return loaded(_that.totalCs,_that.totalUserOnline,_that.totalPending,_that.incompleteCredentials,_that.incompleteCredentialUsers,_that.errors);case DashboardError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class DashboardInitial implements DashboardState {
  const DashboardInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardState.initial()';
}


}




/// @nodoc


class DashboardLoading implements DashboardState {
  const DashboardLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardState.loading()';
}


}




/// @nodoc


class DashboardLoaded implements DashboardState {
  const DashboardLoaded({required this.totalCs, required this.totalUserOnline, required this.totalPending, required this.incompleteCredentials, required  List<IncompleteCredential> incompleteCredentialUsers,  Map<String, String> errors = const <String, String>{}}): _incompleteCredentialUsers = incompleteCredentialUsers,_errors = errors;
  

 final  String totalCs;
 final  String totalUserOnline;
 final  String totalPending;
 final  String incompleteCredentials;
 final  List<IncompleteCredential> _incompleteCredentialUsers;
 List<IncompleteCredential> get incompleteCredentialUsers {
  if (_incompleteCredentialUsers is EqualUnmodifiableListView) return _incompleteCredentialUsers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_incompleteCredentialUsers);
}

 final  Map<String, String> _errors;
@JsonKey() Map<String, String> get errors {
  if (_errors is EqualUnmodifiableMapView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_errors);
}


/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardLoadedCopyWith<DashboardLoaded> get copyWith => _$DashboardLoadedCopyWithImpl<DashboardLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardLoaded&&(identical(other.totalCs, totalCs) || other.totalCs == totalCs)&&(identical(other.totalUserOnline, totalUserOnline) || other.totalUserOnline == totalUserOnline)&&(identical(other.totalPending, totalPending) || other.totalPending == totalPending)&&(identical(other.incompleteCredentials, incompleteCredentials) || other.incompleteCredentials == incompleteCredentials)&&const DeepCollectionEquality().equals(other._incompleteCredentialUsers, _incompleteCredentialUsers)&&const DeepCollectionEquality().equals(other._errors, _errors));
}


@override
int get hashCode => Object.hash(runtimeType,totalCs,totalUserOnline,totalPending,incompleteCredentials,const DeepCollectionEquality().hash(_incompleteCredentialUsers),const DeepCollectionEquality().hash(_errors));

@override
String toString() {
  return 'DashboardState.loaded(totalCs: $totalCs, totalUserOnline: $totalUserOnline, totalPending: $totalPending, incompleteCredentials: $incompleteCredentials, incompleteCredentialUsers: $incompleteCredentialUsers, errors: $errors)';
}


}

/// @nodoc
abstract mixin class $DashboardLoadedCopyWith<$Res> implements $DashboardStateCopyWith<$Res> {
  factory $DashboardLoadedCopyWith(DashboardLoaded value, $Res Function(DashboardLoaded) _then) = _$DashboardLoadedCopyWithImpl;
@useResult
$Res call({
 String totalCs, String totalUserOnline, String totalPending, String incompleteCredentials, List<IncompleteCredential> incompleteCredentialUsers, Map<String, String> errors
});




}
/// @nodoc
class _$DashboardLoadedCopyWithImpl<$Res>
    implements $DashboardLoadedCopyWith<$Res> {
  _$DashboardLoadedCopyWithImpl(this._self, this._then);

  final DashboardLoaded _self;
  final $Res Function(DashboardLoaded) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? totalCs = null,Object? totalUserOnline = null,Object? totalPending = null,Object? incompleteCredentials = null,Object? incompleteCredentialUsers = null,Object? errors = null,}) {
  return _then(DashboardLoaded(
totalCs: null == totalCs ? _self.totalCs : totalCs // ignore: cast_nullable_to_non_nullable
as String,totalUserOnline: null == totalUserOnline ? _self.totalUserOnline : totalUserOnline // ignore: cast_nullable_to_non_nullable
as String,totalPending: null == totalPending ? _self.totalPending : totalPending // ignore: cast_nullable_to_non_nullable
as String,incompleteCredentials: null == incompleteCredentials ? _self.incompleteCredentials : incompleteCredentials // ignore: cast_nullable_to_non_nullable
as String,incompleteCredentialUsers: null == incompleteCredentialUsers ? _self._incompleteCredentialUsers : incompleteCredentialUsers // ignore: cast_nullable_to_non_nullable
as List<IncompleteCredential>,errors: null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}

/// @nodoc


class DashboardError implements DashboardState {
  const DashboardError(this.message);
  

 final  String message;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardErrorCopyWith<DashboardError> get copyWith => _$DashboardErrorCopyWithImpl<DashboardError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'DashboardState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $DashboardErrorCopyWith<$Res> implements $DashboardStateCopyWith<$Res> {
  factory $DashboardErrorCopyWith(DashboardError value, $Res Function(DashboardError) _then) = _$DashboardErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$DashboardErrorCopyWithImpl<$Res>
    implements $DashboardErrorCopyWith<$Res> {
  _$DashboardErrorCopyWithImpl(this._self, this._then);

  final DashboardError _self;
  final $Res Function(DashboardError) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(DashboardError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
