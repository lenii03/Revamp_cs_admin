import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:el_csadmin/features/online/approval/data/models/approval_screen_model.dart';
import 'package:el_csadmin/features/cs/cs_logs/data/models/cs_log_model.dart';
import 'package:el_csadmin/features/cs/manage_cs/data/models/cs_user_model.dart';
import 'package:el_csadmin/features/online/online_id/data/models/online_id_model.dart';
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
      return Left(e.toString());
    }
  }
  
  @override
  Future<Either<String, void>> addCsUser(Map<String, dynamic> requestData) async {
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
      await _networkDataSource.deleteCsUser(loginId); // Sesuaikan nama method di DataSource
      return const Right(null); 
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> editCsUser(Map<String, dynamic> requestData) async {
    try {
      await _networkDataSource.editCsUser(requestData); // Sesuaikan nama method di DataSource
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> resetPassword(Map<String, dynamic> requestData) async {
    try {
      await _networkDataSource.resetPassword(requestData); // Sesuaikan nama method di DataSource
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
