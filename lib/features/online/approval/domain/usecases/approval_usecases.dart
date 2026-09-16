import 'package:dartz/dartz.dart';
import '../../data/models/approval_screen_model.dart';
import '../repositories/approval_repository.dart';

class GetApprovalsUseCase {
  const GetApprovalsUseCase(this._repository);
  final ApprovalRepository _repository;

  Future<Either<String, List<ApprovalScreenModel>>> call({
    String? search,
    int? actionType,
    int? status,
    required int page,
    required int size,
  }) => _repository.fetchApprovals(
    search: search,
    actionType: actionType,
    status: status,
    page: page,
    size: size,
  );
}

class UpdateApprovalStatusUseCase {
  const UpdateApprovalStatusUseCase(this._repository);
  final ApprovalRepository _repository;
  Future<Either<String, String>> call(Map<String, dynamic> payload) =>
      _repository.updateApprovalStatus(payload);
}

class GetApprovalLinkedAccountsDetailUseCase {
  const GetApprovalLinkedAccountsDetailUseCase(this._repository);
  final ApprovalRepository _repository;

  Future<Either<String, Map<String, dynamic>>> call({
    required String loginId,
    required String approvalId,
  }) => _repository.fetchLinkedAccountsDetail(
    loginId: loginId,
    approvalId: approvalId,
  );
}
