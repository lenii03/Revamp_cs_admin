import 'package:dartz/dartz.dart';
import 'package:el_csadmin/features/online/approval/data/models/approval_screen_model.dart';
import 'package:el_csadmin/features/cs/cs_logs/data/models/cs_log_model.dart';
import 'package:el_csadmin/features/cs/manage_cs/data/models/cs_user_model.dart';
import 'package:el_csadmin/features/online/online_id/data/models/online_id_model.dart';
import 'package:el_csadmin/features/user_communication/approve_opening/data/models/approve_opening_account_model.dart';
import 'package:el_csadmin/features/user_communication/notification/data/models/notification_model.dart';

abstract class ApiDatafeedRepository {
  Future<Either<String, List<ManageCsUsersModel>>> fetchCsList();
  Future<Either<String, List<OnlineIdModel>>> fetchOnlineIds({
    String? search,
    int? page,
    int? size,
  });
  Future<Either<String, List<ApprovalScreenModel>>> fetchApprovals({
    String? search,
    int? actionType,
    int? status,
    int page = 1,
    int size = 30,
  });
  Future<Either<String, List<CsLogModel>>> fetchCsLogs({
    String? loginId,
    String? targetId,
    int? logType,
    int? page,
    int? size,
  });
  Future<Either<String, void>> addCsUser(Map<String, dynamic> requestData);
  Future<Either<String, void>> editCsUser(Map<String, dynamic> requestData);
  Future<Either<String, void>> deleteCsUser(String loginId);
  Future<Either<String, void>> resetPassword(Map<String, dynamic> requestData);
  Future<Either<String, List<ApproveOpeningAccountModel>>>
  fetchOpeningAccounts({
    int page = 1,
    int size = 10,
    String? custId,
    String? loginId,
  });
  Future<Either<String, List<ApproveOpeningAccountModel>>>
  fetchOpeningAccountSuggestions();
  Future<Either<String, void>> sendEmailOpeningAccount(
    Map<String, dynamic> payload,
  );
  Future<Either<String, List<NotificationModel>>> fetchSchedulerNotifications({
    int page = 1,
    int size = 10,
  });
  Future<Either<String, String>> sendPushNotification(
    Map<String, dynamic> payload,
  );
  Future<Either<String, String>> createSchedulerNotification(
    Map<String, dynamic> payload,
  );
  Future<Either<String, String>> updateApprovalStatus(
    Map<String, dynamic> payload,
  );
}
