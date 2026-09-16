import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:el_csadmin/data/local/session_service.dart';
import 'package:el_csadmin/features/online/online_id/data/models/online_id_model.dart';
import 'package:el_csadmin/features/online/online_id/domain/usecases/online_id_usecases.dart';
import 'package:el_csadmin/features/user_communication/send_email/data/models/send_email_forgot_model.dart';
import 'package:el_csadmin/features/user_communication/send_email/data/repositories/send_email_queue_repository.dart';

import 'online_id_event.dart';
import 'online_id_state.dart';

class OnlineIdBloc extends Bloc<OnlineIdEvent, OnlineIdState> {
  final SendEmailQueueRepository queueRepository;
  final GetOnlineIdsUseCase _getOnlineIds;
  final SaveOnlineIdUseCase _saveOnlineId;
  final ResetOnlineIdUseCase _resetOnlineId;
  final SessionService _sessionService;
  int currentPage = 1;
  int perPage = 30;
  String currentSearch = '';
  bool _isLoadingMore = false;
  bool _hasReachedEnd = false;
  int _requestVersion = 0;

  OnlineIdBloc({
    required GetOnlineIdsUseCase getOnlineIds,
    required SaveOnlineIdUseCase saveOnlineId,
    required ResetOnlineIdUseCase resetOnlineId,
    required SessionService sessionService,
    required this.queueRepository,
  }) : _getOnlineIds = getOnlineIds,
       _saveOnlineId = saveOnlineId,
       _resetOnlineId = resetOnlineId,
       _sessionService = sessionService,
       super(const OnlineIdState.initial()) {
    on<OnlineIdEvent>((event, emit) async {
      await event.when(
        fetchOnlineIds: () async => await _onFetchOnlineIds(emit),
        loadMoreOnlineIds: () async => await _onLoadMoreOnlineIds(emit),
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
    final requestVersion = ++_requestVersion;
    OnlineIdModel? previousSelectedUser;
    state.maybeMap(
      loaded: (s) => previousSelectedUser = s.selectedUser,
      orElse: () {},
    );

    _isLoadingMore = false;
    _hasReachedEnd = false;
    emit(const OnlineIdState.loading());
    final result = await _getOnlineIds(
      search: currentSearch,
      page: currentPage,
      size: perPage,
    );
    result.fold(
      (error) {
        if (requestVersion != _requestVersion) return;
        emit(OnlineIdState.error(error));
      },
      (data) {
        if (requestVersion != _requestVersion) return;
        _hasReachedEnd = data.length < perPage;
        emit(
          OnlineIdState.loaded(
            data: data,
            selectedUser: previousSelectedUser,
            hasReachedEnd: _hasReachedEnd,
          ),
        );
      },
    );
  }

  Future<void> _onLoadMoreOnlineIds(Emitter<OnlineIdState> emit) async {
    if (_isLoadingMore || _hasReachedEnd) return;

    final loadedState = state.mapOrNull(loaded: (value) => value);
    if (loadedState == null || loadedState.data.isEmpty) return;

    _isLoadingMore = true;
    emit(loadedState.copyWith(isLoadingMore: true));

    final nextPage = currentPage + 1;
    final requestVersion = _requestVersion;
    final result = await _getOnlineIds(
      search: currentSearch,
      page: nextPage,
      size: perPage,
    );

    result.fold(
      (_) {
        if (requestVersion != _requestVersion) return;
        emit(loadedState.copyWith(isLoadingMore: false));
      },
      (nextPageData) {
        if (requestVersion != _requestVersion) return;
        final existingLoginIds = loadedState.data
            .map((user) => user.loginId)
            .toSet();
        final newUsers = nextPageData
            .where((user) => existingLoginIds.add(user.loginId))
            .toList();

        currentPage = nextPage;
        _hasReachedEnd = nextPageData.length < perPage || newUsers.isEmpty;
        emit(
          loadedState.copyWith(
            data: [...loadedState.data, ...newUsers],
            isLoadingMore: false,
            hasReachedEnd: _hasReachedEnd,
          ),
        );
      },
    );

    _isLoadingMore = false;
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
    final result = await _saveOnlineId(data);
    result.fold((error) => emit(OnlineIdState.error(error)), (_) {
      currentPage = 1;
      add(const OnlineIdEvent.fetchOnlineIds());
    });
  }

  Future<void> _onEditOnlineId(
    Map<String, dynamic> data,
    Emitter<OnlineIdState> emit,
  ) async {
    emit(const OnlineIdState.loading());
    final result = await _saveOnlineId(data);
    result.fold((error) => emit(OnlineIdState.error(error)), (_) {
      currentPage = 1;
      add(const OnlineIdEvent.fetchOnlineIds());
    });
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

    final result = await _saveOnlineId(payload);
    result.fold((error) => emit(OnlineIdState.error(error)), (_) {
      currentPage = 1;
      add(const OnlineIdEvent.fetchOnlineIds());
    });
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
      final modifiedBy = _sessionService.read(SessionKey.loginId);
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
      final requestId = '${now.microsecondsSinceEpoch}-$loginId-$actionType';
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

      final resetResult = await _resetOnlineId({
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
      currentPage = 1;
      add(const OnlineIdEvent.fetchOnlineIds());
    } catch (e) {
      emit(
        OnlineIdState.error("Failed to add request to queue: ${e.toString()}"),
      );
    }
  }
}
