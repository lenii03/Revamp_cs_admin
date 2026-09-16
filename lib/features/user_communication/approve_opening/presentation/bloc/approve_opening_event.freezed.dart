// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'approve_opening_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApproveOpeningEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApproveOpeningEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApproveOpeningEvent()';
}


}

/// @nodoc
class $ApproveOpeningEventCopyWith<$Res>  {
$ApproveOpeningEventCopyWith(ApproveOpeningEvent _, $Res Function(ApproveOpeningEvent) __);
}


/// Adds pattern-matching-related methods to [ApproveOpeningEvent].
extension ApproveOpeningEventPatterns on ApproveOpeningEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AddToStaging value)?  addToStaging,TResult Function( RemoveFromStaging value)?  removeFromStaging,TResult Function( ClearStaging value)?  clearStaging,TResult Function( SelectStagedAccount value)?  selectStagedAccount,TResult Function( SendEmailOpeningAccount value)?  sendEmailOpeningAccount,TResult Function( SendEmailOpeningAccountToAll value)?  sendEmailOpeningAccountToAll,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AddToStaging() when addToStaging != null:
return addToStaging(_that);case RemoveFromStaging() when removeFromStaging != null:
return removeFromStaging(_that);case ClearStaging() when clearStaging != null:
return clearStaging(_that);case SelectStagedAccount() when selectStagedAccount != null:
return selectStagedAccount(_that);case SendEmailOpeningAccount() when sendEmailOpeningAccount != null:
return sendEmailOpeningAccount(_that);case SendEmailOpeningAccountToAll() when sendEmailOpeningAccountToAll != null:
return sendEmailOpeningAccountToAll(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AddToStaging value)  addToStaging,required TResult Function( RemoveFromStaging value)  removeFromStaging,required TResult Function( ClearStaging value)  clearStaging,required TResult Function( SelectStagedAccount value)  selectStagedAccount,required TResult Function( SendEmailOpeningAccount value)  sendEmailOpeningAccount,required TResult Function( SendEmailOpeningAccountToAll value)  sendEmailOpeningAccountToAll,}){
final _that = this;
switch (_that) {
case AddToStaging():
return addToStaging(_that);case RemoveFromStaging():
return removeFromStaging(_that);case ClearStaging():
return clearStaging(_that);case SelectStagedAccount():
return selectStagedAccount(_that);case SendEmailOpeningAccount():
return sendEmailOpeningAccount(_that);case SendEmailOpeningAccountToAll():
return sendEmailOpeningAccountToAll(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AddToStaging value)?  addToStaging,TResult? Function( RemoveFromStaging value)?  removeFromStaging,TResult? Function( ClearStaging value)?  clearStaging,TResult? Function( SelectStagedAccount value)?  selectStagedAccount,TResult? Function( SendEmailOpeningAccount value)?  sendEmailOpeningAccount,TResult? Function( SendEmailOpeningAccountToAll value)?  sendEmailOpeningAccountToAll,}){
final _that = this;
switch (_that) {
case AddToStaging() when addToStaging != null:
return addToStaging(_that);case RemoveFromStaging() when removeFromStaging != null:
return removeFromStaging(_that);case ClearStaging() when clearStaging != null:
return clearStaging(_that);case SelectStagedAccount() when selectStagedAccount != null:
return selectStagedAccount(_that);case SendEmailOpeningAccount() when sendEmailOpeningAccount != null:
return sendEmailOpeningAccount(_that);case SendEmailOpeningAccountToAll() when sendEmailOpeningAccountToAll != null:
return sendEmailOpeningAccountToAll(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( ApproveOpeningAccountModel account)?  addToStaging,TResult Function( ApproveOpeningAccountModel account)?  removeFromStaging,TResult Function()?  clearStaging,TResult Function( ApproveOpeningAccountModel account)?  selectStagedAccount,TResult Function( String loginId,  String custId)?  sendEmailOpeningAccount,TResult Function()?  sendEmailOpeningAccountToAll,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AddToStaging() when addToStaging != null:
return addToStaging(_that.account);case RemoveFromStaging() when removeFromStaging != null:
return removeFromStaging(_that.account);case ClearStaging() when clearStaging != null:
return clearStaging();case SelectStagedAccount() when selectStagedAccount != null:
return selectStagedAccount(_that.account);case SendEmailOpeningAccount() when sendEmailOpeningAccount != null:
return sendEmailOpeningAccount(_that.loginId,_that.custId);case SendEmailOpeningAccountToAll() when sendEmailOpeningAccountToAll != null:
return sendEmailOpeningAccountToAll();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( ApproveOpeningAccountModel account)  addToStaging,required TResult Function( ApproveOpeningAccountModel account)  removeFromStaging,required TResult Function()  clearStaging,required TResult Function( ApproveOpeningAccountModel account)  selectStagedAccount,required TResult Function( String loginId,  String custId)  sendEmailOpeningAccount,required TResult Function()  sendEmailOpeningAccountToAll,}) {final _that = this;
switch (_that) {
case AddToStaging():
return addToStaging(_that.account);case RemoveFromStaging():
return removeFromStaging(_that.account);case ClearStaging():
return clearStaging();case SelectStagedAccount():
return selectStagedAccount(_that.account);case SendEmailOpeningAccount():
return sendEmailOpeningAccount(_that.loginId,_that.custId);case SendEmailOpeningAccountToAll():
return sendEmailOpeningAccountToAll();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( ApproveOpeningAccountModel account)?  addToStaging,TResult? Function( ApproveOpeningAccountModel account)?  removeFromStaging,TResult? Function()?  clearStaging,TResult? Function( ApproveOpeningAccountModel account)?  selectStagedAccount,TResult? Function( String loginId,  String custId)?  sendEmailOpeningAccount,TResult? Function()?  sendEmailOpeningAccountToAll,}) {final _that = this;
switch (_that) {
case AddToStaging() when addToStaging != null:
return addToStaging(_that.account);case RemoveFromStaging() when removeFromStaging != null:
return removeFromStaging(_that.account);case ClearStaging() when clearStaging != null:
return clearStaging();case SelectStagedAccount() when selectStagedAccount != null:
return selectStagedAccount(_that.account);case SendEmailOpeningAccount() when sendEmailOpeningAccount != null:
return sendEmailOpeningAccount(_that.loginId,_that.custId);case SendEmailOpeningAccountToAll() when sendEmailOpeningAccountToAll != null:
return sendEmailOpeningAccountToAll();case _:
  return null;

}
}

}

/// @nodoc


class AddToStaging implements ApproveOpeningEvent {
  const AddToStaging(this.account);
  

 final  ApproveOpeningAccountModel account;

/// Create a copy of ApproveOpeningEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddToStagingCopyWith<AddToStaging> get copyWith => _$AddToStagingCopyWithImpl<AddToStaging>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddToStaging&&(identical(other.account, account) || other.account == account));
}


@override
int get hashCode => Object.hash(runtimeType,account);

@override
String toString() {
  return 'ApproveOpeningEvent.addToStaging(account: $account)';
}


}

/// @nodoc
abstract mixin class $AddToStagingCopyWith<$Res> implements $ApproveOpeningEventCopyWith<$Res> {
  factory $AddToStagingCopyWith(AddToStaging value, $Res Function(AddToStaging) _then) = _$AddToStagingCopyWithImpl;
@useResult
$Res call({
 ApproveOpeningAccountModel account
});




}
/// @nodoc
class _$AddToStagingCopyWithImpl<$Res>
    implements $AddToStagingCopyWith<$Res> {
  _$AddToStagingCopyWithImpl(this._self, this._then);

  final AddToStaging _self;
  final $Res Function(AddToStaging) _then;

/// Create a copy of ApproveOpeningEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? account = null,}) {
  return _then(AddToStaging(
null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as ApproveOpeningAccountModel,
  ));
}


}

/// @nodoc


class RemoveFromStaging implements ApproveOpeningEvent {
  const RemoveFromStaging(this.account);
  

 final  ApproveOpeningAccountModel account;

/// Create a copy of ApproveOpeningEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemoveFromStagingCopyWith<RemoveFromStaging> get copyWith => _$RemoveFromStagingCopyWithImpl<RemoveFromStaging>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemoveFromStaging&&(identical(other.account, account) || other.account == account));
}


@override
int get hashCode => Object.hash(runtimeType,account);

@override
String toString() {
  return 'ApproveOpeningEvent.removeFromStaging(account: $account)';
}


}

/// @nodoc
abstract mixin class $RemoveFromStagingCopyWith<$Res> implements $ApproveOpeningEventCopyWith<$Res> {
  factory $RemoveFromStagingCopyWith(RemoveFromStaging value, $Res Function(RemoveFromStaging) _then) = _$RemoveFromStagingCopyWithImpl;
@useResult
$Res call({
 ApproveOpeningAccountModel account
});




}
/// @nodoc
class _$RemoveFromStagingCopyWithImpl<$Res>
    implements $RemoveFromStagingCopyWith<$Res> {
  _$RemoveFromStagingCopyWithImpl(this._self, this._then);

  final RemoveFromStaging _self;
  final $Res Function(RemoveFromStaging) _then;

/// Create a copy of ApproveOpeningEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? account = null,}) {
  return _then(RemoveFromStaging(
null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as ApproveOpeningAccountModel,
  ));
}


}

/// @nodoc


class ClearStaging implements ApproveOpeningEvent {
  const ClearStaging();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClearStaging);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApproveOpeningEvent.clearStaging()';
}


}




/// @nodoc


class SelectStagedAccount implements ApproveOpeningEvent {
  const SelectStagedAccount(this.account);
  

 final  ApproveOpeningAccountModel account;

/// Create a copy of ApproveOpeningEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectStagedAccountCopyWith<SelectStagedAccount> get copyWith => _$SelectStagedAccountCopyWithImpl<SelectStagedAccount>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectStagedAccount&&(identical(other.account, account) || other.account == account));
}


@override
int get hashCode => Object.hash(runtimeType,account);

@override
String toString() {
  return 'ApproveOpeningEvent.selectStagedAccount(account: $account)';
}


}

/// @nodoc
abstract mixin class $SelectStagedAccountCopyWith<$Res> implements $ApproveOpeningEventCopyWith<$Res> {
  factory $SelectStagedAccountCopyWith(SelectStagedAccount value, $Res Function(SelectStagedAccount) _then) = _$SelectStagedAccountCopyWithImpl;
@useResult
$Res call({
 ApproveOpeningAccountModel account
});




}
/// @nodoc
class _$SelectStagedAccountCopyWithImpl<$Res>
    implements $SelectStagedAccountCopyWith<$Res> {
  _$SelectStagedAccountCopyWithImpl(this._self, this._then);

  final SelectStagedAccount _self;
  final $Res Function(SelectStagedAccount) _then;

/// Create a copy of ApproveOpeningEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? account = null,}) {
  return _then(SelectStagedAccount(
null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as ApproveOpeningAccountModel,
  ));
}


}

/// @nodoc


class SendEmailOpeningAccount implements ApproveOpeningEvent {
  const SendEmailOpeningAccount({required this.loginId, required this.custId});
  

 final  String loginId;
 final  String custId;

/// Create a copy of ApproveOpeningEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendEmailOpeningAccountCopyWith<SendEmailOpeningAccount> get copyWith => _$SendEmailOpeningAccountCopyWithImpl<SendEmailOpeningAccount>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendEmailOpeningAccount&&(identical(other.loginId, loginId) || other.loginId == loginId)&&(identical(other.custId, custId) || other.custId == custId));
}


@override
int get hashCode => Object.hash(runtimeType,loginId,custId);

@override
String toString() {
  return 'ApproveOpeningEvent.sendEmailOpeningAccount(loginId: $loginId, custId: $custId)';
}


}

/// @nodoc
abstract mixin class $SendEmailOpeningAccountCopyWith<$Res> implements $ApproveOpeningEventCopyWith<$Res> {
  factory $SendEmailOpeningAccountCopyWith(SendEmailOpeningAccount value, $Res Function(SendEmailOpeningAccount) _then) = _$SendEmailOpeningAccountCopyWithImpl;
@useResult
$Res call({
 String loginId, String custId
});




}
/// @nodoc
class _$SendEmailOpeningAccountCopyWithImpl<$Res>
    implements $SendEmailOpeningAccountCopyWith<$Res> {
  _$SendEmailOpeningAccountCopyWithImpl(this._self, this._then);

  final SendEmailOpeningAccount _self;
  final $Res Function(SendEmailOpeningAccount) _then;

/// Create a copy of ApproveOpeningEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? loginId = null,Object? custId = null,}) {
  return _then(SendEmailOpeningAccount(
loginId: null == loginId ? _self.loginId : loginId // ignore: cast_nullable_to_non_nullable
as String,custId: null == custId ? _self.custId : custId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SendEmailOpeningAccountToAll implements ApproveOpeningEvent {
  const SendEmailOpeningAccountToAll();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendEmailOpeningAccountToAll);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApproveOpeningEvent.sendEmailOpeningAccountToAll()';
}


}




// dart format on
