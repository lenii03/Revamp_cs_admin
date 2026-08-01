import 'package:el_csadmin/features/user_communication/send_email/data/repositories/send_email_queue_repository.dart';
import 'package:el_csadmin/features/user_communication/send_email/presentation/bloc/send_email_event.dart';
import 'package:el_csadmin/features/user_communication/send_email/presentation/bloc/send_email_state.dart';
import 'package:el_csadmin/shared/features/api_datafeed/data/datasources/api_datafeed_network_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:el_csadmin/data/local/session_service.dart';
import 'package:el_csadmin/injector.dart';

class SendEmailForgotBloc
    extends Bloc<SendEmailForgotEvent, SendEmailForgotState> {
  final ApiDatafeedNetworkDataSource apiDataSource;
  final SendEmailQueueRepository queueRepository;

  SendEmailForgotBloc({
    required this.apiDataSource,
    required this.queueRepository,
  }) : super(const SendEmailForgotState()) {
    on<FetchSendEmailData>(_onFetchData);
    on<SubmitSendEmail>(_onSubmitEmail);
  }

  Future<void> _onFetchData(
    FetchSendEmailData event,
    Emitter<SendEmailForgotState> emit,
  ) async {
    emit(state.copyWith(status: SendEmailForgotStatus.loading));
    try {
      final loadedData = queueRepository.load();

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
      final sessionService = locator<SessionService>();
      final currentCsLoginId = sessionService.read(SessionKey.loginId);
      if (currentCsLoginId.isEmpty) {
        throw Exception(
          'Session LoginId CS tidak ditemukan. Silakan login ulang.',
        );
      }

      await apiDataSource.sendEmailForgotPinPassword(
        event.data.loginId,
        event.data.actionType,
        currentCsLoginId,
      );

      final updatedList = await queueRepository.markAsSent(event.index);

      emit(
        state.copyWith(
          status: SendEmailForgotStatus.success,
          dataList: updatedList,
          message:
              "Send Email Forgot ${event.data.actionType == 1 ? 'PIN' : 'Password'} Success",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SendEmailForgotStatus.failure,
          message: "Terjadi kesalahan sistem: ${e.toString()}",
        ),
      );
    }
  }
}
