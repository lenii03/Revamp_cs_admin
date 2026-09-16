import 'package:freezed_annotation/freezed_annotation.dart';

part 'manage_cs_event.freezed.dart';

@freezed
abstract class ManageCsEvent with _$ManageCsEvent {
  const factory ManageCsEvent.fetchCsList({
    @Default(1) int page,
    @Default(30) int pageSize,
  }) = FetchCsList;

  const factory ManageCsEvent.searchCsUser(String query) = SearchCsUser;

  const factory ManageCsEvent.changeCsPage(int page) = ChangeCsPage;

  const factory ManageCsEvent.changeCsPageSize(int pageSize) = ChangeCsPageSize;

  const factory ManageCsEvent.addCsUser(Map<String, dynamic> requestData) =
      AddCsUser;

  const factory ManageCsEvent.editCsUser(Map<String, dynamic> requestData) =
      EditCsUser;

  const factory ManageCsEvent.deleteCsUser({
    required String loginId,
    required String deletedBy,
  }) = DeleteCsUser;

  const factory ManageCsEvent.resetPasswordCsUser(
    Map<String, dynamic> requestData,
  ) = ResetPasswordCsUser;
}
