// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manage_cs_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ManageCsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ManageCsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ManageCsEvent()';
}


}

/// @nodoc
class $ManageCsEventCopyWith<$Res>  {
$ManageCsEventCopyWith(ManageCsEvent _, $Res Function(ManageCsEvent) __);
}


/// Adds pattern-matching-related methods to [ManageCsEvent].
extension ManageCsEventPatterns on ManageCsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FetchCsList value)?  fetchCsList,TResult Function( SearchCsUser value)?  searchCsUser,TResult Function( ChangeCsPage value)?  changeCsPage,TResult Function( ChangeCsPageSize value)?  changeCsPageSize,TResult Function( AddCsUser value)?  addCsUser,TResult Function( EditCsUser value)?  editCsUser,TResult Function( DeleteCsUser value)?  deleteCsUser,TResult Function( ResetPasswordCsUser value)?  resetPasswordCsUser,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FetchCsList() when fetchCsList != null:
return fetchCsList(_that);case SearchCsUser() when searchCsUser != null:
return searchCsUser(_that);case ChangeCsPage() when changeCsPage != null:
return changeCsPage(_that);case ChangeCsPageSize() when changeCsPageSize != null:
return changeCsPageSize(_that);case AddCsUser() when addCsUser != null:
return addCsUser(_that);case EditCsUser() when editCsUser != null:
return editCsUser(_that);case DeleteCsUser() when deleteCsUser != null:
return deleteCsUser(_that);case ResetPasswordCsUser() when resetPasswordCsUser != null:
return resetPasswordCsUser(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FetchCsList value)  fetchCsList,required TResult Function( SearchCsUser value)  searchCsUser,required TResult Function( ChangeCsPage value)  changeCsPage,required TResult Function( ChangeCsPageSize value)  changeCsPageSize,required TResult Function( AddCsUser value)  addCsUser,required TResult Function( EditCsUser value)  editCsUser,required TResult Function( DeleteCsUser value)  deleteCsUser,required TResult Function( ResetPasswordCsUser value)  resetPasswordCsUser,}){
final _that = this;
switch (_that) {
case FetchCsList():
return fetchCsList(_that);case SearchCsUser():
return searchCsUser(_that);case ChangeCsPage():
return changeCsPage(_that);case ChangeCsPageSize():
return changeCsPageSize(_that);case AddCsUser():
return addCsUser(_that);case EditCsUser():
return editCsUser(_that);case DeleteCsUser():
return deleteCsUser(_that);case ResetPasswordCsUser():
return resetPasswordCsUser(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FetchCsList value)?  fetchCsList,TResult? Function( SearchCsUser value)?  searchCsUser,TResult? Function( ChangeCsPage value)?  changeCsPage,TResult? Function( ChangeCsPageSize value)?  changeCsPageSize,TResult? Function( AddCsUser value)?  addCsUser,TResult? Function( EditCsUser value)?  editCsUser,TResult? Function( DeleteCsUser value)?  deleteCsUser,TResult? Function( ResetPasswordCsUser value)?  resetPasswordCsUser,}){
final _that = this;
switch (_that) {
case FetchCsList() when fetchCsList != null:
return fetchCsList(_that);case SearchCsUser() when searchCsUser != null:
return searchCsUser(_that);case ChangeCsPage() when changeCsPage != null:
return changeCsPage(_that);case ChangeCsPageSize() when changeCsPageSize != null:
return changeCsPageSize(_that);case AddCsUser() when addCsUser != null:
return addCsUser(_that);case EditCsUser() when editCsUser != null:
return editCsUser(_that);case DeleteCsUser() when deleteCsUser != null:
return deleteCsUser(_that);case ResetPasswordCsUser() when resetPasswordCsUser != null:
return resetPasswordCsUser(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int page,  int pageSize)?  fetchCsList,TResult Function( String query)?  searchCsUser,TResult Function( int page)?  changeCsPage,TResult Function( int pageSize)?  changeCsPageSize,TResult Function( Map<String, dynamic> requestData)?  addCsUser,TResult Function( Map<String, dynamic> requestData)?  editCsUser,TResult Function( String loginId,  String deletedBy)?  deleteCsUser,TResult Function( Map<String, dynamic> requestData)?  resetPasswordCsUser,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FetchCsList() when fetchCsList != null:
return fetchCsList(_that.page,_that.pageSize);case SearchCsUser() when searchCsUser != null:
return searchCsUser(_that.query);case ChangeCsPage() when changeCsPage != null:
return changeCsPage(_that.page);case ChangeCsPageSize() when changeCsPageSize != null:
return changeCsPageSize(_that.pageSize);case AddCsUser() when addCsUser != null:
return addCsUser(_that.requestData);case EditCsUser() when editCsUser != null:
return editCsUser(_that.requestData);case DeleteCsUser() when deleteCsUser != null:
return deleteCsUser(_that.loginId,_that.deletedBy);case ResetPasswordCsUser() when resetPasswordCsUser != null:
return resetPasswordCsUser(_that.requestData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int page,  int pageSize)  fetchCsList,required TResult Function( String query)  searchCsUser,required TResult Function( int page)  changeCsPage,required TResult Function( int pageSize)  changeCsPageSize,required TResult Function( Map<String, dynamic> requestData)  addCsUser,required TResult Function( Map<String, dynamic> requestData)  editCsUser,required TResult Function( String loginId,  String deletedBy)  deleteCsUser,required TResult Function( Map<String, dynamic> requestData)  resetPasswordCsUser,}) {final _that = this;
switch (_that) {
case FetchCsList():
return fetchCsList(_that.page,_that.pageSize);case SearchCsUser():
return searchCsUser(_that.query);case ChangeCsPage():
return changeCsPage(_that.page);case ChangeCsPageSize():
return changeCsPageSize(_that.pageSize);case AddCsUser():
return addCsUser(_that.requestData);case EditCsUser():
return editCsUser(_that.requestData);case DeleteCsUser():
return deleteCsUser(_that.loginId,_that.deletedBy);case ResetPasswordCsUser():
return resetPasswordCsUser(_that.requestData);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int page,  int pageSize)?  fetchCsList,TResult? Function( String query)?  searchCsUser,TResult? Function( int page)?  changeCsPage,TResult? Function( int pageSize)?  changeCsPageSize,TResult? Function( Map<String, dynamic> requestData)?  addCsUser,TResult? Function( Map<String, dynamic> requestData)?  editCsUser,TResult? Function( String loginId,  String deletedBy)?  deleteCsUser,TResult? Function( Map<String, dynamic> requestData)?  resetPasswordCsUser,}) {final _that = this;
switch (_that) {
case FetchCsList() when fetchCsList != null:
return fetchCsList(_that.page,_that.pageSize);case SearchCsUser() when searchCsUser != null:
return searchCsUser(_that.query);case ChangeCsPage() when changeCsPage != null:
return changeCsPage(_that.page);case ChangeCsPageSize() when changeCsPageSize != null:
return changeCsPageSize(_that.pageSize);case AddCsUser() when addCsUser != null:
return addCsUser(_that.requestData);case EditCsUser() when editCsUser != null:
return editCsUser(_that.requestData);case DeleteCsUser() when deleteCsUser != null:
return deleteCsUser(_that.loginId,_that.deletedBy);case ResetPasswordCsUser() when resetPasswordCsUser != null:
return resetPasswordCsUser(_that.requestData);case _:
  return null;

}
}

}

/// @nodoc


class FetchCsList implements ManageCsEvent {
  const FetchCsList({this.page = 1, this.pageSize = 30});
  

@JsonKey() final  int page;
@JsonKey() final  int pageSize;

/// Create a copy of ManageCsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FetchCsListCopyWith<FetchCsList> get copyWith => _$FetchCsListCopyWithImpl<FetchCsList>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchCsList&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}


@override
int get hashCode => Object.hash(runtimeType,page,pageSize);

@override
String toString() {
  return 'ManageCsEvent.fetchCsList(page: $page, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class $FetchCsListCopyWith<$Res> implements $ManageCsEventCopyWith<$Res> {
  factory $FetchCsListCopyWith(FetchCsList value, $Res Function(FetchCsList) _then) = _$FetchCsListCopyWithImpl;
@useResult
$Res call({
 int page, int pageSize
});




}
/// @nodoc
class _$FetchCsListCopyWithImpl<$Res>
    implements $FetchCsListCopyWith<$Res> {
  _$FetchCsListCopyWithImpl(this._self, this._then);

  final FetchCsList _self;
  final $Res Function(FetchCsList) _then;

/// Create a copy of ManageCsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? page = null,Object? pageSize = null,}) {
  return _then(FetchCsList(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class SearchCsUser implements ManageCsEvent {
  const SearchCsUser(this.query);
  

 final  String query;

/// Create a copy of ManageCsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchCsUserCopyWith<SearchCsUser> get copyWith => _$SearchCsUserCopyWithImpl<SearchCsUser>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchCsUser&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'ManageCsEvent.searchCsUser(query: $query)';
}


}

/// @nodoc
abstract mixin class $SearchCsUserCopyWith<$Res> implements $ManageCsEventCopyWith<$Res> {
  factory $SearchCsUserCopyWith(SearchCsUser value, $Res Function(SearchCsUser) _then) = _$SearchCsUserCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class _$SearchCsUserCopyWithImpl<$Res>
    implements $SearchCsUserCopyWith<$Res> {
  _$SearchCsUserCopyWithImpl(this._self, this._then);

  final SearchCsUser _self;
  final $Res Function(SearchCsUser) _then;

/// Create a copy of ManageCsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(SearchCsUser(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ChangeCsPage implements ManageCsEvent {
  const ChangeCsPage(this.page);
  

 final  int page;

/// Create a copy of ManageCsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangeCsPageCopyWith<ChangeCsPage> get copyWith => _$ChangeCsPageCopyWithImpl<ChangeCsPage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangeCsPage&&(identical(other.page, page) || other.page == page));
}


@override
int get hashCode => Object.hash(runtimeType,page);

@override
String toString() {
  return 'ManageCsEvent.changeCsPage(page: $page)';
}


}

/// @nodoc
abstract mixin class $ChangeCsPageCopyWith<$Res> implements $ManageCsEventCopyWith<$Res> {
  factory $ChangeCsPageCopyWith(ChangeCsPage value, $Res Function(ChangeCsPage) _then) = _$ChangeCsPageCopyWithImpl;
@useResult
$Res call({
 int page
});




}
/// @nodoc
class _$ChangeCsPageCopyWithImpl<$Res>
    implements $ChangeCsPageCopyWith<$Res> {
  _$ChangeCsPageCopyWithImpl(this._self, this._then);

  final ChangeCsPage _self;
  final $Res Function(ChangeCsPage) _then;

/// Create a copy of ManageCsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? page = null,}) {
  return _then(ChangeCsPage(
null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class ChangeCsPageSize implements ManageCsEvent {
  const ChangeCsPageSize(this.pageSize);
  

 final  int pageSize;

/// Create a copy of ManageCsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangeCsPageSizeCopyWith<ChangeCsPageSize> get copyWith => _$ChangeCsPageSizeCopyWithImpl<ChangeCsPageSize>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangeCsPageSize&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}


@override
int get hashCode => Object.hash(runtimeType,pageSize);

@override
String toString() {
  return 'ManageCsEvent.changeCsPageSize(pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class $ChangeCsPageSizeCopyWith<$Res> implements $ManageCsEventCopyWith<$Res> {
  factory $ChangeCsPageSizeCopyWith(ChangeCsPageSize value, $Res Function(ChangeCsPageSize) _then) = _$ChangeCsPageSizeCopyWithImpl;
@useResult
$Res call({
 int pageSize
});




}
/// @nodoc
class _$ChangeCsPageSizeCopyWithImpl<$Res>
    implements $ChangeCsPageSizeCopyWith<$Res> {
  _$ChangeCsPageSizeCopyWithImpl(this._self, this._then);

  final ChangeCsPageSize _self;
  final $Res Function(ChangeCsPageSize) _then;

/// Create a copy of ManageCsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? pageSize = null,}) {
  return _then(ChangeCsPageSize(
null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class AddCsUser implements ManageCsEvent {
  const AddCsUser( Map<String, dynamic> requestData): _requestData = requestData;
  

 final  Map<String, dynamic> _requestData;
 Map<String, dynamic> get requestData {
  if (_requestData is EqualUnmodifiableMapView) return _requestData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_requestData);
}


/// Create a copy of ManageCsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddCsUserCopyWith<AddCsUser> get copyWith => _$AddCsUserCopyWithImpl<AddCsUser>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddCsUser&&const DeepCollectionEquality().equals(other._requestData, _requestData));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_requestData));

@override
String toString() {
  return 'ManageCsEvent.addCsUser(requestData: $requestData)';
}


}

/// @nodoc
abstract mixin class $AddCsUserCopyWith<$Res> implements $ManageCsEventCopyWith<$Res> {
  factory $AddCsUserCopyWith(AddCsUser value, $Res Function(AddCsUser) _then) = _$AddCsUserCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> requestData
});




}
/// @nodoc
class _$AddCsUserCopyWithImpl<$Res>
    implements $AddCsUserCopyWith<$Res> {
  _$AddCsUserCopyWithImpl(this._self, this._then);

  final AddCsUser _self;
  final $Res Function(AddCsUser) _then;

/// Create a copy of ManageCsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? requestData = null,}) {
  return _then(AddCsUser(
null == requestData ? _self._requestData : requestData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

/// @nodoc


class EditCsUser implements ManageCsEvent {
  const EditCsUser( Map<String, dynamic> requestData): _requestData = requestData;
  

 final  Map<String, dynamic> _requestData;
 Map<String, dynamic> get requestData {
  if (_requestData is EqualUnmodifiableMapView) return _requestData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_requestData);
}


/// Create a copy of ManageCsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditCsUserCopyWith<EditCsUser> get copyWith => _$EditCsUserCopyWithImpl<EditCsUser>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditCsUser&&const DeepCollectionEquality().equals(other._requestData, _requestData));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_requestData));

@override
String toString() {
  return 'ManageCsEvent.editCsUser(requestData: $requestData)';
}


}

/// @nodoc
abstract mixin class $EditCsUserCopyWith<$Res> implements $ManageCsEventCopyWith<$Res> {
  factory $EditCsUserCopyWith(EditCsUser value, $Res Function(EditCsUser) _then) = _$EditCsUserCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> requestData
});




}
/// @nodoc
class _$EditCsUserCopyWithImpl<$Res>
    implements $EditCsUserCopyWith<$Res> {
  _$EditCsUserCopyWithImpl(this._self, this._then);

  final EditCsUser _self;
  final $Res Function(EditCsUser) _then;

/// Create a copy of ManageCsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? requestData = null,}) {
  return _then(EditCsUser(
null == requestData ? _self._requestData : requestData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

/// @nodoc


class DeleteCsUser implements ManageCsEvent {
  const DeleteCsUser({required this.loginId, required this.deletedBy});
  

 final  String loginId;
 final  String deletedBy;

/// Create a copy of ManageCsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteCsUserCopyWith<DeleteCsUser> get copyWith => _$DeleteCsUserCopyWithImpl<DeleteCsUser>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteCsUser&&(identical(other.loginId, loginId) || other.loginId == loginId)&&(identical(other.deletedBy, deletedBy) || other.deletedBy == deletedBy));
}


@override
int get hashCode => Object.hash(runtimeType,loginId,deletedBy);

@override
String toString() {
  return 'ManageCsEvent.deleteCsUser(loginId: $loginId, deletedBy: $deletedBy)';
}


}

/// @nodoc
abstract mixin class $DeleteCsUserCopyWith<$Res> implements $ManageCsEventCopyWith<$Res> {
  factory $DeleteCsUserCopyWith(DeleteCsUser value, $Res Function(DeleteCsUser) _then) = _$DeleteCsUserCopyWithImpl;
@useResult
$Res call({
 String loginId, String deletedBy
});




}
/// @nodoc
class _$DeleteCsUserCopyWithImpl<$Res>
    implements $DeleteCsUserCopyWith<$Res> {
  _$DeleteCsUserCopyWithImpl(this._self, this._then);

  final DeleteCsUser _self;
  final $Res Function(DeleteCsUser) _then;

/// Create a copy of ManageCsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? loginId = null,Object? deletedBy = null,}) {
  return _then(DeleteCsUser(
loginId: null == loginId ? _self.loginId : loginId // ignore: cast_nullable_to_non_nullable
as String,deletedBy: null == deletedBy ? _self.deletedBy : deletedBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ResetPasswordCsUser implements ManageCsEvent {
  const ResetPasswordCsUser( Map<String, dynamic> requestData): _requestData = requestData;
  

 final  Map<String, dynamic> _requestData;
 Map<String, dynamic> get requestData {
  if (_requestData is EqualUnmodifiableMapView) return _requestData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_requestData);
}


/// Create a copy of ManageCsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResetPasswordCsUserCopyWith<ResetPasswordCsUser> get copyWith => _$ResetPasswordCsUserCopyWithImpl<ResetPasswordCsUser>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordCsUser&&const DeepCollectionEquality().equals(other._requestData, _requestData));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_requestData));

@override
String toString() {
  return 'ManageCsEvent.resetPasswordCsUser(requestData: $requestData)';
}


}

/// @nodoc
abstract mixin class $ResetPasswordCsUserCopyWith<$Res> implements $ManageCsEventCopyWith<$Res> {
  factory $ResetPasswordCsUserCopyWith(ResetPasswordCsUser value, $Res Function(ResetPasswordCsUser) _then) = _$ResetPasswordCsUserCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> requestData
});




}
/// @nodoc
class _$ResetPasswordCsUserCopyWithImpl<$Res>
    implements $ResetPasswordCsUserCopyWith<$Res> {
  _$ResetPasswordCsUserCopyWithImpl(this._self, this._then);

  final ResetPasswordCsUser _self;
  final $Res Function(ResetPasswordCsUser) _then;

/// Create a copy of ManageCsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? requestData = null,}) {
  return _then(ResetPasswordCsUser(
null == requestData ? _self._requestData : requestData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
