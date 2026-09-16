import 'package:dartz/dartz.dart';
import '../entities/manage_cs_user.dart';

abstract class ManageCsRepository {
  Future<Either<String, List<ManageCsUser>>> fetchUsers({
    required int page,
    required int pageSize,
  });

  Future<Either<String, void>> addUser(Map<String, dynamic> payload);
  Future<Either<String, void>> editUser(Map<String, dynamic> payload);
  Future<Either<String, void>> deleteUser({
    required String loginId,
    required String deletedBy,
  });
  Future<Either<String, void>> resetPassword(Map<String, dynamic> payload);
}
