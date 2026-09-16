import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_email_event.freezed.dart';

@freezed
abstract class SendEmailForgotEvent with _$SendEmailForgotEvent {
  const factory SendEmailForgotEvent.fetchSendEmailData() =
      FetchSendEmailData;
}
