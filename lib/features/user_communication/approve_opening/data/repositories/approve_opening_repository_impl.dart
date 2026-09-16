import 'package:dartz/dartz.dart';
import '../../domain/repositories/approve_opening_repository.dart';
import '../datasources/approve_opening_remote_data_source.dart';
import '../models/approve_opening_account_model.dart';

class ApproveOpeningRepositoryImpl implements ApproveOpeningRepository {
  const ApproveOpeningRepositoryImpl(this._remoteDataSource);
  final ApproveOpeningRemoteDataSource _remoteDataSource;

  @override
  Future<Either<String, List<ApproveOpeningAccountModel>>> fetchAccounts({int page = 1, int size = 10, String? custId, String? loginId}) async {
    try {
      final data = await _remoteDataSource.fetchAccounts(page: page, size: size, custId: custId, loginId: loginId);
      return Right(data.map((item) => ApproveOpeningAccountModel.fromMap(item as Map<String, dynamic>)).toList());
    } catch (error) { return Left(error.toString().replaceFirst('Exception: ', '')); }
  }
  @override
  Future<Either<String, List<ApproveOpeningAccountModel>>> fetchSuggestions() async {
    try {
      final data = await _remoteDataSource.fetchSuggestions();
      return Right(data.map((item) => ApproveOpeningAccountModel.fromMap(item as Map<String, dynamic>)).toList());
    } catch (error) { return Left(error.toString().replaceFirst('Exception: ', '')); }
  }
  @override
  Future<Either<String, void>> sendEmail(Map<String, dynamic> payload) async {
    try { await _remoteDataSource.sendEmail(payload); return const Right(null); }
    catch (error) { return Left(error.toString().replaceFirst('Exception: ', '')); }
  }
}
