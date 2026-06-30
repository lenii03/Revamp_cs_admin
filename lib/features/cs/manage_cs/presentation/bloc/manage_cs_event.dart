abstract class ManageCsEvent {}

class FetchCsList extends ManageCsEvent {}
class SearchCsUser extends ManageCsEvent {
  final String query;
  SearchCsUser(this.query);
}
class AddCsUser extends ManageCsEvent {
  final Map<String, dynamic> requestData; 
  AddCsUser(this.requestData);
}
class EditCsUser extends ManageCsEvent {
  final Map<String, dynamic> requestData;
  EditCsUser(this.requestData);
}

class DeleteCsUser extends ManageCsEvent {
  final String loginId;
  DeleteCsUser(this.loginId);
}

class ResetPasswordCsUser extends ManageCsEvent {
  final Map<String, dynamic> requestData;
  ResetPasswordCsUser(this.requestData);
}