import 'package:dartz/dartz.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_remote_data_source.dart';
import '../models/notification_model.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  const NotificationRepositoryImpl(this._remoteDataSource);
  final NotificationRemoteDataSource _remoteDataSource;
  @override
  Future<Either<String, List<NotificationModel>>> fetchSchedulers() async {
    try {
      final data = await _remoteDataSource.fetchSchedulers();
      return Right(
        data
            .map(
              (item) =>
                  NotificationModel.fromJson(item as Map<String, dynamic>),
            )
            .toList(),
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> createScheduler(
    Map<String, dynamic> payload,
  ) async {
    try {
      await _remoteDataSource.createScheduler(payload);
      return const Right('Scheduler created successfully');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
