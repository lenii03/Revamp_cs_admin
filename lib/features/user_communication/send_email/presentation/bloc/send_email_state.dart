import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/send_email_forgot_model.dart';

part 'send_email_state.freezed.dart';

enum SendEmailForgotStatus { initial, loading, loaded, success, failure }

@freezed
abstract class SendEmailForgotState with _$SendEmailForgotState {
  const factory SendEmailForgotState({
    @Default(SendEmailForgotStatus.initial) SendEmailForgotStatus status,
    @Default(<SendEmailForgotModel>[]) List<SendEmailForgotModel> dataList,
    @Default('') String message,
  }) = _SendEmailForgotState;
}
