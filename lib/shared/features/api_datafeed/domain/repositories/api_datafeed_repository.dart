import 'package:dartz/dartz.dart';
import 'package:el_csadmin/features/online/approval/data/models/approval_screen_model.dart';
import 'package:el_csadmin/features/cs/cs_logs/data/models/cs_log_model.dart';
import 'package:el_csadmin/features/cs/manage_cs/data/models/cs_user_model.dart';
import 'package:el_csadmin/features/online/online_id/data/models/online_id_model.dart';

abstract class ApiDatafeedRepository {
  Future<Either<String, List<ManageCsUsersModel>>> fetchCsList();
  Future<Either<String, List<OnlineIdModel>>> fetchOnlineIds();
  Future<Either<String, List<ApprovalScreenModel>>> fetchApprovals();
  Future<Either<String, List<CsLogModel>>> fetchCsLogs({
    String? loginId,
    String? targetId,
  });
  Future<Either<String, void>> addCsUser(Map<String, dynamic> requestData);
  Future<Either<String, void>> editCsUser(Map<String, dynamic> requestData);
  Future<Either<String, void>> deleteCsUser(String loginId);
  Future<Either<String, void>> resetPassword(Map<String, dynamic> requestData);
}
