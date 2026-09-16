import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/entities/manage_cs_user.dart';
import '../../domain/repositories/manage_cs_repository.dart';
import '../datasources/manage_cs_remote_data_source.dart';

class ManageCsRepositoryImpl implements ManageCsRepository {
  const ManageCsRepositoryImpl(this._remoteDataSource);

  final ManageCsRemoteDataSource _remoteDataSource;

  @override
  Future<Either<String, List<ManageCsUser>>> fetchUsers({
    required int page,
    required int pageSize,
  }) async {
    try {
      final users = await _remoteDataSource.fetchUsers(
        page: page,
        pageSize: pageSize,
      );
      return Right(users.map((user) => user.toEntity()).toList());
    } catch (error) {
      return Left(_errorMessage(error));
    }
  }

  @override
  Future<Either<String, void>> addUser(Map<String, dynamic> payload) =>
      _run(() => _remoteDataSource.addUser(payload));

  @override
  Future<Either<String, void>> editUser(Map<String, dynamic> payload) =>
      _run(() => _remoteDataSource.editUser(payload));

  @override
  Future<Either<String, void>> deleteUser({
    required String loginId,
    required String deletedBy,
  }) =>
      _run(
        () => _remoteDataSource.deleteUser(
          loginId: loginId,
          deletedBy: deletedBy,
        ),
      );

  @override
  Future<Either<String, void>> resetPassword(Map<String, dynamic> payload) =>
      _run(() => _remoteDataSource.resetPassword(payload));

  Future<Either<String, void>> _run(Future<void> Function() action) async {
    try {
      await action();
      return const Right(null);
    } catch (error) {
      return Left(_errorMessage(error));
    }
  }

  String _errorMessage(Object error) {
    if (error is DioException) {
      final data = error.response?.data;
      if (data is Map && data['message'] != null) return data['message'].toString();
      return error.message ?? 'A network error occurred.';
    }
    return error.toString().replaceFirst('Exception: ', '');
  }
}
