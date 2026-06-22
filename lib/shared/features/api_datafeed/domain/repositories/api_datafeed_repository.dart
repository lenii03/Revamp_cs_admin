import 'package:dartz/dartz.dart';
import 'package:el_csadmin/features/approval/data/models/approval_screen_model.dart';
import 'package:el_csadmin/features/cs_logs/data/models/cs_log_model.dart';
import 'package:el_csadmin/features/manage_cs/data/models/cs_user_model.dart';
import 'package:el_csadmin/features/online/data/models/online_id_model.dart';

abstract class ApiDatafeedRepository {
  Future<Either<String, List<CsUserModel>>> fetchCsList();
  Future<Either<String, List<OnlineIdModel>>> fetchOnlineIds();
  Future<Either<String, List<ApprovalScreenModel>>> fetchApprovals();
  Future<Either<String, List<CsLogModel>>> fetchCsLogs({
    String? loginId,
    String? targetId,
  });
}
