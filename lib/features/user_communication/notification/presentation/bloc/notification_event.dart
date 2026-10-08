abstract class NotificationEvent {
  const NotificationEvent();
}

class FetchSchedulers extends NotificationEvent {
  const FetchSchedulers();
}

class CreateScheduler extends NotificationEvent {
  const CreateScheduler(this.payload);

  final Map<String, dynamic> payload;
}
