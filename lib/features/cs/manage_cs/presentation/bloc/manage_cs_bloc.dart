import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/features/api_datafeed/domain/repositories/api_datafeed_repository.dart';
import 'manage_cs_event.dart';
import 'manage_cs_state.dart';
import '../../data/models/cs_user_model.dart';

class ManageCsBloc extends Bloc<ManageCsEvent, ManageCsState> {
  final ApiDatafeedRepository repository;
  List<ManageCsUsersModel> _allUsers = [];
  int currentPage = 1;
  int perPage = 30;

  ManageCsBloc({required this.repository}) : super(ManageCsInitial()) {
    on<FetchCsList>((event, emit) async {
      emit(ManageCsLoading());
      final result = await repository.fetchCsList();

      result.fold((error) => emit(ManageCsError(error)), (data) {
        _allUsers = data;
        emit(ManageCsLoaded(_allUsers));
      });
    });

    on<SearchCsUser>((event, emit) async {
      if (event.query.isEmpty) {
        emit(ManageCsLoaded(_allUsers));
        return;
      }
      final query = event.query.toLowerCase().trim();
      final filteredUsers = _allUsers.where((user) {
        return user.loginId.toLowerCase().contains(query) ||
            user.employeeId.toLowerCase().contains(query) ||
            (user.email.toLowerCase().contains(query));
      }).toList();
      emit(ManageCsLoaded(filteredUsers));
    });

    on<AddCsUser>((event, emit) async {
      emit(ManageCsLoading());
      final result = await repository.addCsUser(event.requestData);
      result.fold(
        (error) => emit(ManageCsError("Gagal menyimpan data: $error")),
        (_) => add(FetchCsList()),
      );
    });
    on<EditCsUser>((event, emit) async {
      emit(ManageCsLoading());
      final result = await repository.editCsUser(event.requestData);
      result.fold(
        (error) => emit(ManageCsError("Gagal mengedit data: $error")),
        (_) => add(FetchCsList()),
      );
    });

    on<DeleteCsUser>((event, emit) async {
      emit(ManageCsLoading());
      final result = await repository.deleteCsUser(event.loginId);
      result.fold(
        (error) => emit(ManageCsError("Gagal menghapus data: $error")),
        (_) => add(FetchCsList()),
      );
    });

    on<ResetPasswordCsUser>((event, emit) async {
      emit(ManageCsLoading());
      final result = await repository.resetPassword(event.requestData);
      result.fold(
        (error) => emit(ManageCsError("Gagal mereset password: $error")),
        (_) => add(FetchCsList()),
      );
    });
  }
}
