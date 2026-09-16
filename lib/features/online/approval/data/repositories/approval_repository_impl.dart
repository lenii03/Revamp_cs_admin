import 'package:dartz/dartz.dart';
import '../../domain/repositories/approval_repository.dart';
import '../datasources/approval_remote_data_source.dart';
import '../models/approval_screen_model.dart';

class ApprovalRepositoryImpl implements ApprovalRepository {
  const ApprovalRepositoryImpl(this._remoteDataSource);
  final ApprovalRemoteDataSource _remoteDataSource;

  @override
  Future<Either<String, List<ApprovalScreenModel>>> fetchApprovals({
    String? search,
    int? actionType,
    int? status,
    required int page,
    required int size,
  }) async {
    try {
      return Right(
        await _remoteDataSource.fetchApprovals(
          search: search,
          actionType: actionType,
          status: status,
          page: page,
          size: size,
        ),
      );
    } catch (error) {
      return Left(error.toString().replaceFirst('Exception: ', ''));
    }
  }

  @override
  Future<Either<String, String>> updateApprovalStatus(
    Map<String, dynamic> payload,
  ) async {
    try {
      await _remoteDataSource.updateApprovalStatus(payload);
      return const Right('Approval status updated successfully');
    } catch (error) {
      return Left(error.toString().replaceFirst('Exception: ', ''));
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> fetchLinkedAccountsDetail({
    required String loginId,
    required String approvalId,
  }) async {
    try {
      return Right(
        await _remoteDataSource.fetchLinkedAccountsDetail(
          loginId: loginId,
          approvalId: approvalId,
        ),
      );
    } catch (error) {
      return Left(error.toString().replaceFirst('Exception: ', ''));
    }
  }
}
