import 'package:dartz/dartz.dart';
import '../../data/models/notification_model.dart';

abstract class NotificationRepository {
  Future<Either<String, List<NotificationModel>>> fetchSchedulers();
  Future<Either<String, String>> sendPush(Map<String, dynamic> payload);
  Future<Either<String, String>> createScheduler(Map<String, dynamic> payload);
}
