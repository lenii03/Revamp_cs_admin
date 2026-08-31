import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:el_csadmin/data/local/session_service.dart';
import 'package:el_csadmin/injector.dart';
import 'package:el_csadmin/features/online/online_id/data/repositories/online_id_repository.dart';
import 'package:el_csadmin/features/online/online_id/data/models/online_id_model.dart';
import 'package:el_csadmin/features/user_communication/send_email/data/models/send_email_forgot_model.dart';
import 'package:el_csadmin/features/user_communication/send_email/data/repositories/send_email_queue_repository.dart';

import 'online_id_event.dart';
import 'online_id_state.dart';

class OnlineIdBloc extends Bloc<OnlineIdEvent, OnlineIdState> {
  final OnlineIdRepository repository;
  final SendEmailQueueRepository queueRepository;
  int currentPage = 1;
  int perPage = 30;
  String currentSearch = '';

  OnlineIdBloc({required this.repository, required this.queueRepository})
    : super(const OnlineIdState.initial()) {
    on<OnlineIdEvent>((event, emit) async {
      await event.when(
        fetchOnlineIds: () async => await _onFetchOnlineIds(emit),
        addOnlineId: (data) async => await _onAddOnlineId(data, emit),
        editOnlineId: (data) async => await _onEditOnlineId(data, emit),
        deleteOnlineId: (loginId) async =>
            await _onDeleteOnlineId(loginId, emit),
        resetOnlineId: (loginId, resetType) async =>
            await _onResetOnlineId(loginId, resetType, emit),
        selectOnlineId: (selectedUser) async {
          _onSelectOnlineId(selectedUser, emit);
        },

        searchOnlineIds: (query) async => await _onSearchOnlineIds(query, emit),
      );
    });
  }

  Future<void> _onSearchOnlineIds(
    String query,
    Emitter<OnlineIdState> emit,
  ) async {
    currentSearch = query;
    currentPage = 1;
    await _onFetchOnlineIds(emit);
  }

  Future<void> _onFetchOnlineIds(Emitter<OnlineIdState> emit) async {
    OnlineIdModel? previousSelectedUser;
    state.maybeMap(
      loaded: (s) => previousSelectedUser = s.selectedUser,
      orElse: () {},
    );

    emit(const OnlineIdState.loading());
    final result = await repository.fetchOnlineIds(
      search: currentSearch,
      page: currentPage,
      size: perPage,
    );
    result.fold(
      (error) => emit(OnlineIdState.error(error)),
      (data) => emit(
        OnlineIdState.loaded(data: data, selectedUser: previousSelectedUser),
      ),
    );
  }

  void _onSelectOnlineId(
    OnlineIdModel selectedUser,
    Emitter<OnlineIdState> emit,
  ) {
    state.maybeMap(
      loaded: (s) {
        emit(s.copyWith(selectedUser: selectedUser));
      },
      orElse: () {},
    );
  }

  Future<void> _onAddOnlineId(
    Map<String, dynamic> data,
    Emitter<OnlineIdState> emit,
  ) async {
    emit(const OnlineIdState.loading());
    final result = await repository.addOnlineUser1(data);
    result.fold(
      (error) => emit(OnlineIdState.error(error)),
      (_) => add(const OnlineIdEvent.fetchOnlineIds()),
    );
  }

  Future<void> _onEditOnlineId(
    Map<String, dynamic> data,
    Emitter<OnlineIdState> emit,
  ) async {
    emit(const OnlineIdState.loading());
    final result = await repository.addOnlineUser1(data);
    result.fold(
      (error) => emit(OnlineIdState.error(error)),
      (_) => add(const OnlineIdEvent.fetchOnlineIds()),
    );
  }

  Future<void> _onDeleteOnlineId(
    String loginId,
    Emitter<OnlineIdState> emit,
  ) async {
    emit(const OnlineIdState.loading());
    final payload = {
      "LoginId": loginId,
      "ActionType": 3,
      "Status": 0,
      "ArrayAccountLink": [],
      "ArrayAccountUnLink": [],
    };

    final result = await repository.addOnlineUser1(payload);
    result.fold(
      (error) => emit(OnlineIdState.error(error)),
      (_) => add(const OnlineIdEvent.fetchOnlineIds()),
    );
  }

  Future<void> _onResetOnlineId(
    String loginId,
    String resetType,
    Emitter<OnlineIdState> emit,
  ) async {
    String email = "-";
    int loginType = 1;

    state.maybeMap(
      loaded: (s) {
        if (s.selectedUser != null) {
          email = s.selectedUser!.email;
          loginType = s.selectedUser!.loginType;
        }
      },
      orElse: () {},
    );

    emit(const OnlineIdState.loading());

    try {
      final int actionType = resetType == "password" ? 0 : 1;
      final sessionService = locator<SessionService>();
      final modifiedBy = sessionService.read(SessionKey.loginId);
      if (modifiedBy.isEmpty) {
        emit(
          const OnlineIdState.error(
            'CS LoginId session was not found. Please log in again.',
          ),
        );
        return;
      }

      // Catat request lebih dahulu. Backend reset dapat mengirim email tetapi
      // responsnya terlambat/timeout; request tetap harus terlihat di antrean.
      final now = DateTime.now();
      final requestId =
          '${now.microsecondsSinceEpoch}-$loginId-$actionType';
      await queueRepository.enqueue(
        SendEmailForgotModel(
          actionType: actionType,
          loginId: loginId,
          email: email,
          loginType: loginType,
          status: 1,
          requestId: requestId,
          source: 'new',
          createdAt: now.toIso8601String(),
        ),
      );

      final resetResult = await repository.resetPasswordOrPin({
        'LoginId': loginId,
        'ModifiedBy': modifiedBy,
        'ActionType': actionType,
        'Email': email == '-' ? '' : email,
      });

      String? resetError;
      resetResult.fold((error) => resetError = error, (_) {});
      if (resetError != null) {
        emit(OnlineIdState.error('Failed to reset Password/PIN: $resetError'));
        return;
      }

      await queueRepository.markAsSentByRequestId(requestId);
      add(const OnlineIdEvent.fetchOnlineIds());
    } catch (e) {
      emit(
        OnlineIdState.error("Failed to add request to queue: ${e.toString()}"),
      );
    }
  }
}
