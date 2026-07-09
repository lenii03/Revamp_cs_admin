import 'package:equatable/equatable.dart';
import '../../data/models/send_email_forgot_model.dart';

enum SendEmailForgotStatus { initial, loading, loaded, success, failure }

class SendEmailForgotState extends Equatable {
  final SendEmailForgotStatus status;
  final List<SendEmailForgotModel> dataList;
  final String message;

  const SendEmailForgotState({
    this.status = SendEmailForgotStatus.initial,
    this.dataList = const [],
    this.message = '',
  });

  SendEmailForgotState copyWith({
    SendEmailForgotStatus? status,
    List<SendEmailForgotModel>? dataList,
    String? message,
  }) {
    return SendEmailForgotState(
      status: status ?? this.status,
      dataList: dataList ?? this.dataList,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, dataList, message];
}