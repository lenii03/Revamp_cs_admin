import 'dart:convert';

import 'package:el_csadmin/data/local/session_service.dart';
import 'package:el_csadmin/injector.dart';
import 'package:el_csadmin/shared/features/api_datafeed/domain/repositories/api_datafeed_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'online_id_event.dart';
import 'online_id_state.dart';

class OnlineIdBloc extends Bloc<OnlineIdEvent, OnlineIdState> {
  final ApiDatafeedRepository repository;
  int currentPage = 1;
  int perPage = 30;
  String currentSearch = '';

  OnlineIdBloc({required this.repository}) : super(OnlineIdInitial()) {
    on<FetchOnlineIdsEvent>((event, emit) async {
      emit(OnlineIdLoading());

      final result = await repository.fetchOnlineIds(
        search: currentSearch,
        page: currentPage,
        size: perPage,
      );

      result.fold(
        (error) => emit(OnlineIdError(error)),
        (data) => emit(OnlineIdLoaded(data: data)),
      );
    });

    on<SelectOnlineIdEvent>((event, emit) {
      if (state is OnlineIdLoaded) {
        final currentState = state as OnlineIdLoaded;
        emit(currentState.copyWith(selectedUser: event.selectedUser));
      }
    });

    on<AddOnlineIdEvent>((event, emit) async {
      emit(OnlineIdLoading());
      final result = await repository.addCsUser(event.data);
      result.fold(
        (error) => emit(OnlineIdError(error)),
        (_) => add(FetchOnlineIdsEvent()),
      );
    });

    on<ResetOnlineIdEvent>((event, emit) async {
      emit(OnlineIdLoading());

      try {
        String email = "-";
        int loginType = 1;

        if (state is OnlineIdLoaded) {
          final currentUser = (state as OnlineIdLoaded).selectedUser;
          if (currentUser != null) {
            email = currentUser.email;
            loginType = currentUser.loginType;
          }
        }
        final int actionType = event.resetType == "password" ? 0 : 1;
        final sessionService = locator<SessionService>();
        final String rawString = sessionService.read(SessionKey.listPwdNPIN);

        print("📝 [SENDER] DATA LAMA DI STORAGE: $rawString");
        List<dynamic> existingList = [];

        final oldData = sessionService.readDB(
          SessionKey.listPwdNPIN,
          (json) => json['ListEmailForgotPINAndPassword'] as List<dynamic>?,
        );

        if (oldData != null) {
          existingList = List.from(oldData);
        }
        existingList.add({
          "actionType": actionType,
          "loginId": event.loginId,
          "email": email,
          "loginType": loginType,
          "status": 1, // 1 = Pending
        });

        await sessionService.writeDB(SessionKey.listPwdNPIN, {
          'ListEmailForgotPINAndPassword': existingList,
        });

        final jsonToSave = jsonEncode({
          'ListEmailForgotPINAndPassword': existingList,
        });
        print("💾 [SENDER] MENYIMPAN DATA: $jsonToSave");
        await sessionService.write(SessionKey.listPwdNPIN, jsonToSave);

        // Refresh tabel Online ID
        add(FetchOnlineIdsEvent());
      } catch (e) {
        emit(OnlineIdError("Gagal menambahkan ke antrean: ${e.toString()}"));
      }
    });
  }
}
