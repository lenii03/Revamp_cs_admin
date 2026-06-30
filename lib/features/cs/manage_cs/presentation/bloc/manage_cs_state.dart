import '../../data/models/cs_user_model.dart';

abstract class ManageCsState {}

class ManageCsInitial extends ManageCsState {}

class ManageCsLoading extends ManageCsState {}

class ManageCsLoaded extends ManageCsState {
  final List<ManageCsUsersModel> csUsers;
  ManageCsLoaded(this.csUsers);
}

class ManageCsError extends ManageCsState {
  final String message;
  ManageCsError(this.message);
}
