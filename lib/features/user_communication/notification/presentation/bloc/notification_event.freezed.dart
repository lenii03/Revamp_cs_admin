// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationEvent()';
}


}

/// @nodoc
class $NotificationEventCopyWith<$Res>  {
$NotificationEventCopyWith(NotificationEvent _, $Res Function(NotificationEvent) __);
}


/// Adds pattern-matching-related methods to [NotificationEvent].
extension NotificationEventPatterns on NotificationEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FetchSchedulers value)?  fetchSchedulers,TResult Function( SendPushNotif value)?  sendPushNotif,TResult Function( CreateScheduler value)?  createScheduler,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FetchSchedulers() when fetchSchedulers != null:
return fetchSchedulers(_that);case SendPushNotif() when sendPushNotif != null:
return sendPushNotif(_that);case CreateScheduler() when createScheduler != null:
return createScheduler(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FetchSchedulers value)  fetchSchedulers,required TResult Function( SendPushNotif value)  sendPushNotif,required TResult Function( CreateScheduler value)  createScheduler,}){
final _that = this;
switch (_that) {
case FetchSchedulers():
return fetchSchedulers(_that);case SendPushNotif():
return sendPushNotif(_that);case CreateScheduler():
return createScheduler(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FetchSchedulers value)?  fetchSchedulers,TResult? Function( SendPushNotif value)?  sendPushNotif,TResult? Function( CreateScheduler value)?  createScheduler,}){
final _that = this;
switch (_that) {
case FetchSchedulers() when fetchSchedulers != null:
return fetchSchedulers(_that);case SendPushNotif() when sendPushNotif != null:
return sendPushNotif(_that);case CreateScheduler() when createScheduler != null:
return createScheduler(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  fetchSchedulers,TResult Function( String title,  String subtitle)?  sendPushNotif,TResult Function( Map<String, dynamic> payload)?  createScheduler,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FetchSchedulers() when fetchSchedulers != null:
return fetchSchedulers();case SendPushNotif() when sendPushNotif != null:
return sendPushNotif(_that.title,_that.subtitle);case CreateScheduler() when createScheduler != null:
return createScheduler(_that.payload);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  fetchSchedulers,required TResult Function( String title,  String subtitle)  sendPushNotif,required TResult Function( Map<String, dynamic> payload)  createScheduler,}) {final _that = this;
switch (_that) {
case FetchSchedulers():
return fetchSchedulers();case SendPushNotif():
return sendPushNotif(_that.title,_that.subtitle);case CreateScheduler():
return createScheduler(_that.payload);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  fetchSchedulers,TResult? Function( String title,  String subtitle)?  sendPushNotif,TResult? Function( Map<String, dynamic> payload)?  createScheduler,}) {final _that = this;
switch (_that) {
case FetchSchedulers() when fetchSchedulers != null:
return fetchSchedulers();case SendPushNotif() when sendPushNotif != null:
return sendPushNotif(_that.title,_that.subtitle);case CreateScheduler() when createScheduler != null:
return createScheduler(_that.payload);case _:
  return null;

}
}

}

/// @nodoc


class FetchSchedulers implements NotificationEvent {
  const FetchSchedulers();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchSchedulers);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationEvent.fetchSchedulers()';
}


}




/// @nodoc


class SendPushNotif implements NotificationEvent {
  const SendPushNotif({required this.title, required this.subtitle});
  

 final  String title;
 final  String subtitle;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendPushNotifCopyWith<SendPushNotif> get copyWith => _$SendPushNotifCopyWithImpl<SendPushNotif>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendPushNotif&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle));
}


@override
int get hashCode => Object.hash(runtimeType,title,subtitle);

@override
String toString() {
  return 'NotificationEvent.sendPushNotif(title: $title, subtitle: $subtitle)';
}


}

/// @nodoc
abstract mixin class $SendPushNotifCopyWith<$Res> implements $NotificationEventCopyWith<$Res> {
  factory $SendPushNotifCopyWith(SendPushNotif value, $Res Function(SendPushNotif) _then) = _$SendPushNotifCopyWithImpl;
@useResult
$Res call({
 String title, String subtitle
});




}
/// @nodoc
class _$SendPushNotifCopyWithImpl<$Res>
    implements $SendPushNotifCopyWith<$Res> {
  _$SendPushNotifCopyWithImpl(this._self, this._then);

  final SendPushNotif _self;
  final $Res Function(SendPushNotif) _then;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? title = null,Object? subtitle = null,}) {
  return _then(SendPushNotif(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CreateScheduler implements NotificationEvent {
  const CreateScheduler( Map<String, dynamic> payload): _payload = payload;
  

 final  Map<String, dynamic> _payload;
 Map<String, dynamic> get payload {
  if (_payload is EqualUnmodifiableMapView) return _payload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_payload);
}


/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateSchedulerCopyWith<CreateScheduler> get copyWith => _$CreateSchedulerCopyWithImpl<CreateScheduler>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateScheduler&&const DeepCollectionEquality().equals(other._payload, _payload));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_payload));

@override
String toString() {
  return 'NotificationEvent.createScheduler(payload: $payload)';
}


}

/// @nodoc
abstract mixin class $CreateSchedulerCopyWith<$Res> implements $NotificationEventCopyWith<$Res> {
  factory $CreateSchedulerCopyWith(CreateScheduler value, $Res Function(CreateScheduler) _then) = _$CreateSchedulerCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> payload
});




}
/// @nodoc
class _$CreateSchedulerCopyWithImpl<$Res>
    implements $CreateSchedulerCopyWith<$Res> {
  _$CreateSchedulerCopyWithImpl(this._self, this._then);

  final CreateScheduler _self;
  final $Res Function(CreateScheduler) _then;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? payload = null,}) {
  return _then(CreateScheduler(
null == payload ? _self._payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
