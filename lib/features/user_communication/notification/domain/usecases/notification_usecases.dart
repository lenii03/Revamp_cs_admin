import 'package:dartz/dartz.dart';
import '../../data/models/notification_model.dart';
import '../repositories/notification_repository.dart';

class GetSchedulersUseCase {
  const GetSchedulersUseCase(this._repository);
  final NotificationRepository _repository;
  Future<Either<String, List<NotificationModel>>> call() =>
      _repository.fetchSchedulers();
}

class CreateSchedulerUseCase {
  const CreateSchedulerUseCase(this._repository);
  final NotificationRepository _repository;
  Future<Either<String, String>> call(Map<String, dynamic> payload) =>
      _repository.createScheduler(payload);
}
