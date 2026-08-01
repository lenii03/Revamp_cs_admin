// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'approval_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApprovalScreenEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApprovalScreenEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApprovalScreenEvent()';
}


}

/// @nodoc
class $ApprovalScreenEventCopyWith<$Res>  {
$ApprovalScreenEventCopyWith(ApprovalScreenEvent _, $Res Function(ApprovalScreenEvent) __);
}


/// Adds pattern-matching-related methods to [ApprovalScreenEvent].
extension ApprovalScreenEventPatterns on ApprovalScreenEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _FetchApprovals value)?  fetchApprovals,TResult Function( _ApproveItem value)?  approveItem,TResult Function( _RejectItem value)?  rejectItem,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FetchApprovals() when fetchApprovals != null:
return fetchApprovals(_that);case _ApproveItem() when approveItem != null:
return approveItem(_that);case _RejectItem() when rejectItem != null:
return rejectItem(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _FetchApprovals value)  fetchApprovals,required TResult Function( _ApproveItem value)  approveItem,required TResult Function( _RejectItem value)  rejectItem,}){
final _that = this;
switch (_that) {
case _FetchApprovals():
return fetchApprovals(_that);case _ApproveItem():
return approveItem(_that);case _RejectItem():
return rejectItem(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _FetchApprovals value)?  fetchApprovals,TResult? Function( _ApproveItem value)?  approveItem,TResult? Function( _RejectItem value)?  rejectItem,}){
final _that = this;
switch (_that) {
case _FetchApprovals() when fetchApprovals != null:
return fetchApprovals(_that);case _ApproveItem() when approveItem != null:
return approveItem(_that);case _RejectItem() when rejectItem != null:
return rejectItem(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  fetchApprovals,TResult Function( ApprovalScreenModel data)?  approveItem,TResult Function( ApprovalScreenModel data)?  rejectItem,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FetchApprovals() when fetchApprovals != null:
return fetchApprovals();case _ApproveItem() when approveItem != null:
return approveItem(_that.data);case _RejectItem() when rejectItem != null:
return rejectItem(_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  fetchApprovals,required TResult Function( ApprovalScreenModel data)  approveItem,required TResult Function( ApprovalScreenModel data)  rejectItem,}) {final _that = this;
switch (_that) {
case _FetchApprovals():
return fetchApprovals();case _ApproveItem():
return approveItem(_that.data);case _RejectItem():
return rejectItem(_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  fetchApprovals,TResult? Function( ApprovalScreenModel data)?  approveItem,TResult? Function( ApprovalScreenModel data)?  rejectItem,}) {final _that = this;
switch (_that) {
case _FetchApprovals() when fetchApprovals != null:
return fetchApprovals();case _ApproveItem() when approveItem != null:
return approveItem(_that.data);case _RejectItem() when rejectItem != null:
return rejectItem(_that.data);case _:
  return null;

}
}

}

/// @nodoc


class _FetchApprovals implements ApprovalScreenEvent {
  const _FetchApprovals();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchApprovals);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApprovalScreenEvent.fetchApprovals()';
}


}




/// @nodoc


class _ApproveItem implements ApprovalScreenEvent {
  const _ApproveItem(this.data);
  

 final  ApprovalScreenModel data;

/// Create a copy of ApprovalScreenEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApproveItemCopyWith<_ApproveItem> get copyWith => __$ApproveItemCopyWithImpl<_ApproveItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApproveItem&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'ApprovalScreenEvent.approveItem(data: $data)';
}


}

/// @nodoc
abstract mixin class _$ApproveItemCopyWith<$Res> implements $ApprovalScreenEventCopyWith<$Res> {
  factory _$ApproveItemCopyWith(_ApproveItem value, $Res Function(_ApproveItem) _then) = __$ApproveItemCopyWithImpl;
@useResult
$Res call({
 ApprovalScreenModel data
});




}
/// @nodoc
class __$ApproveItemCopyWithImpl<$Res>
    implements _$ApproveItemCopyWith<$Res> {
  __$ApproveItemCopyWithImpl(this._self, this._then);

  final _ApproveItem _self;
  final $Res Function(_ApproveItem) _then;

/// Create a copy of ApprovalScreenEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_ApproveItem(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ApprovalScreenModel,
  ));
}


}

/// @nodoc


class _RejectItem implements ApprovalScreenEvent {
  const _RejectItem(this.data);
  

 final  ApprovalScreenModel data;

/// Create a copy of ApprovalScreenEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RejectItemCopyWith<_RejectItem> get copyWith => __$RejectItemCopyWithImpl<_RejectItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RejectItem&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'ApprovalScreenEvent.rejectItem(data: $data)';
}


}

/// @nodoc
abstract mixin class _$RejectItemCopyWith<$Res> implements $ApprovalScreenEventCopyWith<$Res> {
  factory _$RejectItemCopyWith(_RejectItem value, $Res Function(_RejectItem) _then) = __$RejectItemCopyWithImpl;
@useResult
$Res call({
 ApprovalScreenModel data
});




}
/// @nodoc
class __$RejectItemCopyWithImpl<$Res>
    implements _$RejectItemCopyWith<$Res> {
  __$RejectItemCopyWithImpl(this._self, this._then);

  final _RejectItem _self;
  final $Res Function(_RejectItem) _then;

/// Create a copy of ApprovalScreenEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_RejectItem(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as ApprovalScreenModel,
  ));
}


}

// dart format on
