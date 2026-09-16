import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/manage_cs_user.dart';
import '../../domain/usecases/manage_cs_usecases.dart';
import 'manage_cs_event.dart';
import 'manage_cs_state.dart';

class ManageCsBloc extends Bloc<ManageCsEvent, ManageCsState> {
  ManageCsBloc({
    required GetManageCsUsersUseCase getUsers,
    required AddManageCsUserUseCase addUser,
    required EditManageCsUserUseCase editUser,
    required DeleteManageCsUserUseCase deleteUser,
    required ResetManageCsPasswordUseCase resetPassword,
  }) : _getUsers = getUsers,
       _addUser = addUser,
       _editUser = editUser,
       _deleteUser = deleteUser,
       _resetPassword = resetPassword,
       super(const ManageCsState()) {
    on<FetchCsList>(_onFetchUsers);
    on<SearchCsUser>(_onSearchUsers);
    on<ChangeCsPage>(_onChangePage);
    on<ChangeCsPageSize>(_onChangePageSize);
    on<AddCsUser>((event, emit) => _onMutation(
      emit,
      () => _addUser(event.requestData),
      failurePrefix: 'Failed to save data',
    ));
    on<EditCsUser>((event, emit) => _onMutation(
      emit,
      () => _editUser(event.requestData),
      failurePrefix: 'Failed to update data',
    ));
    on<DeleteCsUser>((event, emit) => _onMutation(
      emit,
      () => _deleteUser(loginId: event.loginId, deletedBy: event.deletedBy),
      failurePrefix: 'Failed to delete data',
    ));
    on<ResetPasswordCsUser>((event, emit) => _onMutation(
      emit,
      () => _resetPassword(event.requestData),
      failurePrefix: 'Failed to reset password',
    ));
  }

  final GetManageCsUsersUseCase _getUsers;
  final AddManageCsUserUseCase _addUser;
  final EditManageCsUserUseCase _editUser;
  final DeleteManageCsUserUseCase _deleteUser;
  final ResetManageCsPasswordUseCase _resetPassword;

  Future<void> _onFetchUsers(
    FetchCsList event,
    Emitter<ManageCsState> emit,
  ) async {
    emit(state.copyWith(status: ManageCsStatus.loading, errorMessage: ''));
    final result = await _getUsers(page: event.page, pageSize: event.pageSize);
    result.fold(
      (error) => emit(state.copyWith(
        status: ManageCsStatus.failure,
        errorMessage: error,
      )),
      (users) => emit(state.copyWith(
        status: ManageCsStatus.success,
        allUsers: users,
        csUsers: _filterUsers(users, state.query),
        page: event.page,
        pageSize: event.pageSize,
        errorMessage: '',
      )),
    );
  }

  void _onSearchUsers(SearchCsUser event, Emitter<ManageCsState> emit) {
    final query = event.query.trim();
    emit(state.copyWith(
      status: ManageCsStatus.success,
      query: query,
      csUsers: _filterUsers(state.allUsers, query),
      errorMessage: '',
    ));
  }

  void _onChangePage(ChangeCsPage event, Emitter<ManageCsState> emit) {
    if (event.page >= 1) {
      add(FetchCsList(page: event.page, pageSize: state.pageSize));
    }
  }

  void _onChangePageSize(
    ChangeCsPageSize event,
    Emitter<ManageCsState> emit,
  ) {
    add(FetchCsList(page: 1, pageSize: event.pageSize));
  }

  Future<void> _onMutation(
    Emitter<ManageCsState> emit,
    Future<dynamic> Function() action, {
    required String failurePrefix,
  }) async {
    emit(state.copyWith(status: ManageCsStatus.loading, errorMessage: ''));
    final result = await action();
    result.fold(
      (error) => emit(state.copyWith(
        status: ManageCsStatus.failure,
        errorMessage: '$failurePrefix: $error',
      )),
      (_) => add(FetchCsList(page: state.page, pageSize: state.pageSize)),
    );
  }

  List<ManageCsUser> _filterUsers(List<ManageCsUser> users, String query) {
    if (query.isEmpty) return users;
    final normalizedQuery = query.toLowerCase();
    return users.where((user) {
      return user.loginId.toLowerCase().contains(normalizedQuery) ||
          user.employeeId.toLowerCase().contains(normalizedQuery) ||
          user.email.toLowerCase().contains(normalizedQuery);
    }).toList();
  }
}
