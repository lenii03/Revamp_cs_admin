import 'package:dartz/dartz.dart';
import '../../data/models/approval_screen_model.dart';

abstract class ApprovalRepository {
  Future<Either<String, List<ApprovalScreenModel>>> fetchApprovals({
    String? search,
    int? actionType,
    int? status,
    required int page,
    required int size,
  });

  Future<Either<String, String>> updateApprovalStatus(
    Map<String, dynamic> payload,
  );

  Future<Either<String, Map<String, dynamic>>> fetchLinkedAccountsDetail({
    required String loginId,
    required String approvalId,
  });
}
