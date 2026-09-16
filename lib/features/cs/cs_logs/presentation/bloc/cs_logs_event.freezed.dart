// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cs_logs_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CsLogsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CsLogsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CsLogsEvent()';
}


}

/// @nodoc
class $CsLogsEventCopyWith<$Res>  {
$CsLogsEventCopyWith(CsLogsEvent _, $Res Function(CsLogsEvent) __);
}


/// Adds pattern-matching-related methods to [CsLogsEvent].
extension CsLogsEventPatterns on CsLogsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FetchCsLogsEvent value)?  fetchCsLogs,TResult Function( ChangeCsLogsPage value)?  changeCsLogsPage,TResult Function( ChangeCsLogsPageSize value)?  changeCsLogsPageSize,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FetchCsLogsEvent() when fetchCsLogs != null:
return fetchCsLogs(_that);case ChangeCsLogsPage() when changeCsLogsPage != null:
return changeCsLogsPage(_that);case ChangeCsLogsPageSize() when changeCsLogsPageSize != null:
return changeCsLogsPageSize(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FetchCsLogsEvent value)  fetchCsLogs,required TResult Function( ChangeCsLogsPage value)  changeCsLogsPage,required TResult Function( ChangeCsLogsPageSize value)  changeCsLogsPageSize,}){
final _that = this;
switch (_that) {
case FetchCsLogsEvent():
return fetchCsLogs(_that);case ChangeCsLogsPage():
return changeCsLogsPage(_that);case ChangeCsLogsPageSize():
return changeCsLogsPageSize(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FetchCsLogsEvent value)?  fetchCsLogs,TResult? Function( ChangeCsLogsPage value)?  changeCsLogsPage,TResult? Function( ChangeCsLogsPageSize value)?  changeCsLogsPageSize,}){
final _that = this;
switch (_that) {
case FetchCsLogsEvent() when fetchCsLogs != null:
return fetchCsLogs(_that);case ChangeCsLogsPage() when changeCsLogsPage != null:
return changeCsLogsPage(_that);case ChangeCsLogsPageSize() when changeCsLogsPageSize != null:
return changeCsLogsPageSize(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? loginId,  String? targetId,  int? logType,  int page,  int pageSize)?  fetchCsLogs,TResult Function( int page)?  changeCsLogsPage,TResult Function( int pageSize)?  changeCsLogsPageSize,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FetchCsLogsEvent() when fetchCsLogs != null:
return fetchCsLogs(_that.loginId,_that.targetId,_that.logType,_that.page,_that.pageSize);case ChangeCsLogsPage() when changeCsLogsPage != null:
return changeCsLogsPage(_that.page);case ChangeCsLogsPageSize() when changeCsLogsPageSize != null:
return changeCsLogsPageSize(_that.pageSize);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? loginId,  String? targetId,  int? logType,  int page,  int pageSize)  fetchCsLogs,required TResult Function( int page)  changeCsLogsPage,required TResult Function( int pageSize)  changeCsLogsPageSize,}) {final _that = this;
switch (_that) {
case FetchCsLogsEvent():
return fetchCsLogs(_that.loginId,_that.targetId,_that.logType,_that.page,_that.pageSize);case ChangeCsLogsPage():
return changeCsLogsPage(_that.page);case ChangeCsLogsPageSize():
return changeCsLogsPageSize(_that.pageSize);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? loginId,  String? targetId,  int? logType,  int page,  int pageSize)?  fetchCsLogs,TResult? Function( int page)?  changeCsLogsPage,TResult? Function( int pageSize)?  changeCsLogsPageSize,}) {final _that = this;
switch (_that) {
case FetchCsLogsEvent() when fetchCsLogs != null:
return fetchCsLogs(_that.loginId,_that.targetId,_that.logType,_that.page,_that.pageSize);case ChangeCsLogsPage() when changeCsLogsPage != null:
return changeCsLogsPage(_that.page);case ChangeCsLogsPageSize() when changeCsLogsPageSize != null:
return changeCsLogsPageSize(_that.pageSize);case _:
  return null;

}
}

}

/// @nodoc


class FetchCsLogsEvent implements CsLogsEvent {
  const FetchCsLogsEvent({this.loginId, this.targetId, this.logType, this.page = 1, this.pageSize = 30});
  

 final  String? loginId;
 final  String? targetId;
 final  int? logType;
@JsonKey() final  int page;
@JsonKey() final  int pageSize;

/// Create a copy of CsLogsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FetchCsLogsEventCopyWith<FetchCsLogsEvent> get copyWith => _$FetchCsLogsEventCopyWithImpl<FetchCsLogsEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchCsLogsEvent&&(identical(other.loginId, loginId) || other.loginId == loginId)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.logType, logType) || other.logType == logType)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}


@override
int get hashCode => Object.hash(runtimeType,loginId,targetId,logType,page,pageSize);

@override
String toString() {
  return 'CsLogsEvent.fetchCsLogs(loginId: $loginId, targetId: $targetId, logType: $logType, page: $page, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class $FetchCsLogsEventCopyWith<$Res> implements $CsLogsEventCopyWith<$Res> {
  factory $FetchCsLogsEventCopyWith(FetchCsLogsEvent value, $Res Function(FetchCsLogsEvent) _then) = _$FetchCsLogsEventCopyWithImpl;
@useResult
$Res call({
 String? loginId, String? targetId, int? logType, int page, int pageSize
});




}
/// @nodoc
class _$FetchCsLogsEventCopyWithImpl<$Res>
    implements $FetchCsLogsEventCopyWith<$Res> {
  _$FetchCsLogsEventCopyWithImpl(this._self, this._then);

  final FetchCsLogsEvent _self;
  final $Res Function(FetchCsLogsEvent) _then;

/// Create a copy of CsLogsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? loginId = freezed,Object? targetId = freezed,Object? logType = freezed,Object? page = null,Object? pageSize = null,}) {
  return _then(FetchCsLogsEvent(
loginId: freezed == loginId ? _self.loginId : loginId // ignore: cast_nullable_to_non_nullable
as String?,targetId: freezed == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String?,logType: freezed == logType ? _self.logType : logType // ignore: cast_nullable_to_non_nullable
as int?,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class ChangeCsLogsPage implements CsLogsEvent {
  const ChangeCsLogsPage(this.page);
  

 final  int page;

/// Create a copy of CsLogsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangeCsLogsPageCopyWith<ChangeCsLogsPage> get copyWith => _$ChangeCsLogsPageCopyWithImpl<ChangeCsLogsPage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangeCsLogsPage&&(identical(other.page, page) || other.page == page));
}


@override
int get hashCode => Object.hash(runtimeType,page);

@override
String toString() {
  return 'CsLogsEvent.changeCsLogsPage(page: $page)';
}


}

/// @nodoc
abstract mixin class $ChangeCsLogsPageCopyWith<$Res> implements $CsLogsEventCopyWith<$Res> {
  factory $ChangeCsLogsPageCopyWith(ChangeCsLogsPage value, $Res Function(ChangeCsLogsPage) _then) = _$ChangeCsLogsPageCopyWithImpl;
@useResult
$Res call({
 int page
});




}
/// @nodoc
class _$ChangeCsLogsPageCopyWithImpl<$Res>
    implements $ChangeCsLogsPageCopyWith<$Res> {
  _$ChangeCsLogsPageCopyWithImpl(this._self, this._then);

  final ChangeCsLogsPage _self;
  final $Res Function(ChangeCsLogsPage) _then;

/// Create a copy of CsLogsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? page = null,}) {
  return _then(ChangeCsLogsPage(
null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class ChangeCsLogsPageSize implements CsLogsEvent {
  const ChangeCsLogsPageSize(this.pageSize);
  

 final  int pageSize;

/// Create a copy of CsLogsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangeCsLogsPageSizeCopyWith<ChangeCsLogsPageSize> get copyWith => _$ChangeCsLogsPageSizeCopyWithImpl<ChangeCsLogsPageSize>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangeCsLogsPageSize&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}


@override
int get hashCode => Object.hash(runtimeType,pageSize);

@override
String toString() {
  return 'CsLogsEvent.changeCsLogsPageSize(pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class $ChangeCsLogsPageSizeCopyWith<$Res> implements $CsLogsEventCopyWith<$Res> {
  factory $ChangeCsLogsPageSizeCopyWith(ChangeCsLogsPageSize value, $Res Function(ChangeCsLogsPageSize) _then) = _$ChangeCsLogsPageSizeCopyWithImpl;
@useResult
$Res call({
 int pageSize
});




}
/// @nodoc
class _$ChangeCsLogsPageSizeCopyWithImpl<$Res>
    implements $ChangeCsLogsPageSizeCopyWith<$Res> {
  _$ChangeCsLogsPageSizeCopyWithImpl(this._self, this._then);

  final ChangeCsLogsPageSize _self;
  final $Res Function(ChangeCsLogsPageSize) _then;

/// Create a copy of CsLogsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? pageSize = null,}) {
  return _then(ChangeCsLogsPageSize(
null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
