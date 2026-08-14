import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:el_csadmin/features/online/approval/data/models/approval_screen_model.dart';
import 'package:el_csadmin/features/cs/cs_logs/data/models/cs_log_model.dart';
import 'package:el_csadmin/features/cs/manage_cs/data/models/cs_user_model.dart';
import 'package:el_csadmin/features/online/online_id/data/models/online_id_model.dart';
import 'package:el_csadmin/features/user_communication/approve_opening/data/models/approve_opening_account_model.dart';
import 'package:el_csadmin/features/user_communication/notification/data/models/notification_model.dart';
import 'package:el_csadmin/shared/features/api_datafeed/data/datasources/api_datafeed_network_data_source.dart';
import '../../domain/repositories/api_datafeed_repository.dart';

class ApiDatafeedRepositoryImpl implements ApiDatafeedRepository {
  final ApiDatafeedNetworkDataSource _networkDataSource;

  const ApiDatafeedRepositoryImpl(this._networkDataSource);

  @override
  Future<Either<String, List<ManageCsUsersModel>>> fetchCsList() async {
    try {
      final result = await _networkDataSource.fetchCsList();
      return Right(result.cast<ManageCsUsersModel>());
    } on DioException catch (e) {
      return Left("Gagal mengambil data. Status: ${e.response?.statusCode}");
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<CsLogModel>>> fetchCsLogs({
    String? loginId,
    String? targetId,
    int? logType,
    int? page,
    int? size,
  }) async {
    try {
      final result = await _networkDataSource.fetchCsLogs(
        loginId: loginId,
        targetId: targetId,
        logType: logType,
        page: page,
        size: size,
      );
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<OnlineIdModel>>> fetchOnlineIds({
    String? search,
    int? page,
    int? size,
  }) async {
    try {
      final result = await _networkDataSource.fetchOnlineIds(
        search: search,
        page: page,
        size: size,
      );
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ApprovalScreenModel>>> fetchApprovals({
    String? search,
    int? actionType,
    int? status,
    int page = 1,
    int size = 30,
  }) async {
    try {
      final result = await _networkDataSource.fetchApprovals(
        search: search,
        actionType: actionType,
        status: status,
        page: page,
        size: size,
      );
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> addCsUser(
    Map<String, dynamic> requestData,
  ) async {
    try {
      await _networkDataSource.addCsUser(requestData);
      return const Right(null); // Sukses
    } catch (e) {
      return Left(e.toString()); // Gagal
    }
  }

  @override
  Future<Either<String, void>> deleteCsUser(String loginId) async {
    try {
      await _networkDataSource.deleteCsUser(
        loginId,
      ); // Sesuaikan nama method di DataSource
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> editCsUser(
    Map<String, dynamic> requestData,
  ) async {
    try {
      await _networkDataSource.editCsUser(
        requestData,
      ); // Sesuaikan nama method di DataSource
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> resetPassword(
    Map<String, dynamic> requestData,
  ) async {
    try {
      await _networkDataSource.resetPassword(requestData);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ApproveOpeningAccountModel>>>
  fetchOpeningAccounts({
    int page = 1,
    int size = 10,
    String? custId,
    String? loginId,
  }) async {
    try {
      final rawData = await _networkDataSource.fetchOpeningAccounts(
        page: page,
        size: size,
        custId: custId,
        loginId: loginId,
      );
      final List<ApproveOpeningAccountModel> result = rawData
          .map((data) => ApproveOpeningAccountModel.fromMap(data))
          .toList();

      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ApproveOpeningAccountModel>>>
  fetchOpeningAccountSuggestions() async {
    try {
      final rawData = await _networkDataSource.fetchOpeningAccountSuggestions();
      return Right(
        rawData
            .map(
              (item) => ApproveOpeningAccountModel.fromMap(
                item as Map<String, dynamic>,
              ),
            )
            .toList(),
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> sendEmailOpeningAccount(
    Map<String, dynamic> payload,
  ) async {
    try {
      await _networkDataSource.sendEmailOpeningAccount(payload);
      return const Right(null);
    } catch (e) {
      return Left(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  @override
  Future<Either<String, List<NotificationModel>>> fetchSchedulerNotifications({
    int page = 1,
    int size = 10,
  }) async {
    try {
      final rawData = await _networkDataSource.fetchSchedulerNotifications(
        page: page,
        size: size,
      );
      final List<NotificationModel> result = rawData
          .map((data) => NotificationModel.fromJson(data))
          .toList();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> sendPushNotification(
    Map<String, dynamic> payload,
  ) async {
    try {
      await _networkDataSource.sendPushNotification(payload);
      return const Right("Push Notification berhasil dikirim");
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> createSchedulerNotification(
    Map<String, dynamic> payload,
  ) async {
    try {
      await _networkDataSource.createSchedulerNotification(payload);
      return const Right("Scheduler berhasil dibuat");
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> updateApprovalStatus(
    Map<String, dynamic> payload,
  ) async {
    try {
      await _networkDataSource.updateApprovalStatus(payload);
      return const Right("Status approval berhasil diubah");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
