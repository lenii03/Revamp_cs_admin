abstract class SendEmailForgotEvent {
  const SendEmailForgotEvent();
}

class FetchSendEmailData extends SendEmailForgotEvent {
  const FetchSendEmailData();
}

class ClearPendingRequests extends SendEmailForgotEvent {
  const ClearPendingRequests();
}
