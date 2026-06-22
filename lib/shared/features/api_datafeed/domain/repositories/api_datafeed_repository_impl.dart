import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:el_csadmin/features/approval/data/models/approval_screen_model.dart';
import 'package:el_csadmin/features/cs_logs/data/models/cs_log_model.dart';
import 'package:el_csadmin/features/online/data/models/online_id_model.dart';
import 'package:el_csadmin/shared/features/api_datafeed/data/datasources/api_datafeed_network_data_source.dart';
import '../../domain/repositories/api_datafeed_repository.dart';
import '../../../../../features/manage_cs/data/models/cs_user_model.dart';

class ApiDatafeedRepositoryImpl implements ApiDatafeedRepository {
  final ApiDatafeedNetworkDataSource _networkDataSource;

  const ApiDatafeedRepositoryImpl(this._networkDataSource);

  @override
  Future<Either<String, List<CsUserModel>>> fetchCsList() async {
    try {
      final result = await _networkDataSource.fetchCsList();
      return Right(result);
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
  }) async {
    try {
      final result = await _networkDataSource.fetchCsLogs(
        loginId: loginId,
        targetId: targetId,
      );
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<OnlineIdModel>>> fetchOnlineIds() async {
    try {
      final result = await _networkDataSource.fetchOnlineIds();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ApprovalScreenModel>>> fetchApprovals() async {
    try {
      final result = await _networkDataSource.fetchApprovals();
      return Right(result);
    } catch (e) {
      // Menangkap error jika API gagal atau data bermasalah
      return Left(e.toString());
    }
  }
}
