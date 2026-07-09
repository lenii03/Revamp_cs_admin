import 'dart:convert';

import 'package:el_csadmin/features/user_communication/send_email/data/models/send_email_forgot_model.dart';
import 'package:el_csadmin/features/user_communication/send_email/presentation/bloc/send_email_event.dart';
import 'package:el_csadmin/features/user_communication/send_email/presentation/bloc/send_email_state.dart';
import 'package:el_csadmin/shared/features/api_datafeed/data/datasources/api_datafeed_network_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:el_csadmin/data/local/session_service.dart';
import 'package:el_csadmin/injector.dart';

class SendEmailForgotBloc
    extends Bloc<SendEmailForgotEvent, SendEmailForgotState> {
  final ApiDatafeedNetworkDataSource apiDataSource;

  SendEmailForgotBloc({required this.apiDataSource})
    : super(const SendEmailForgotState()) {
    on<FetchSendEmailData>(_onFetchData);
    on<SubmitSendEmail>(_onSubmitEmail);
  }

  Future<void> _onFetchData(
    FetchSendEmailData event,
    Emitter<SendEmailForgotState> emit,
  ) async {
    emit(state.copyWith(status: SendEmailForgotStatus.loading));
    try {
      final sessionService = locator<SessionService>();

      final String rawString = sessionService.read(SessionKey.listPwdNPIN);
      print("📥 [RECEIVER] MEMBACA DATA DI SEND EMAIL: $rawString");

      List<SendEmailForgotModel> loadedData = [];

      // 👇 PERBAIKAN: Kita decode rawString secara manual, HAPUS sessionService.readDB
      if (rawString.isNotEmpty) {
        final Map<String, dynamic> decodedData = jsonDecode(rawString);

        if (decodedData['ListEmailForgotPINAndPassword'] != null) {
          final List<dynamic> listData =
              decodedData['ListEmailForgotPINAndPassword'];

          loadedData = listData
              .map(
                (item) => SendEmailForgotModel(
                  actionType: int.tryParse(item['actionType'].toString()) ?? 1,
                  loginId: item['loginId']?.toString() ?? '-',
                  email: item['email']?.toString() ?? '-',
                  loginType: int.tryParse(item['loginType'].toString()) ?? 1,
                  status: int.tryParse(item['status'].toString()) ?? 1,
                ),
              )
              .toList();
        }
      }

      emit(
        state.copyWith(
          status: SendEmailForgotStatus.loaded,
          dataList: loadedData,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SendEmailForgotStatus.failure,
          message: "Gagal memuat data lokal: ${e.toString()}",
        ),
      );
    }
  }

  Future<void> _onSubmitEmail(
    SubmitSendEmail event,
    Emitter<SendEmailForgotState> emit,
  ) async {
    emit(state.copyWith(status: SendEmailForgotStatus.loading));
    try {
      const String currentCsLoginId = 'admin';
      // Tembak API Asli
      final bool isSuccess = await apiDataSource.sendEmailForgotPinPassword(
        event.data.loginId,
        event.data.actionType,
        currentCsLoginId,
      );

      if (isSuccess) {
        final List<SendEmailForgotModel> updatedList = List.from(
          state.dataList,
        );
        updatedList[event.index].status = 2; // Ubah status menjadi Email Send

        // Simpan pembaruan status ke DB Lokal
        final List<Map<String, dynamic>> rawListToSave = updatedList
            .map(
              (e) => {
                "actionType": e.actionType,
                "loginId": e.loginId,
                "email": e.email,
                "loginType": e.loginType,
                "status": e.status,
              },
            )
            .toList();

        final sessionService = locator<SessionService>();
        await sessionService.writeDB(SessionKey.listPwdNPIN, {
          'ListEmailForgotPINAndPassword': rawListToSave,
        });

        emit(
          state.copyWith(
            status: SendEmailForgotStatus.success,
            dataList: updatedList,
            message:
                "Send Email Forgot ${event.data.actionType == 1 ? 'PIN' : 'Password'} Success",
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: SendEmailForgotStatus.failure,
            message: "Gagal mengirim email. Silakan coba lagi.",
          ),
        );
      }
    } catch (e) {
      print("❌ [RECEIVER] ERROR: $e");
      emit(
        state.copyWith(
          status: SendEmailForgotStatus.failure,
          message: "Terjadi kesalahan sistem: ${e.toString()}",
        ),
      );
    }
  }
}
