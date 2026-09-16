import 'package:dartz/dartz.dart';
import '../entities/manage_cs_user.dart';
import '../repositories/manage_cs_repository.dart';

class GetManageCsUsersUseCase {
  const GetManageCsUsersUseCase(this._repository);
  final ManageCsRepository _repository;

  Future<Either<String, List<ManageCsUser>>> call({
    required int page,
    required int pageSize,
  }) =>
      _repository.fetchUsers(page: page, pageSize: pageSize);
}

class AddManageCsUserUseCase {
  const AddManageCsUserUseCase(this._repository);
  final ManageCsRepository _repository;
  Future<Either<String, void>> call(Map<String, dynamic> payload) =>
      _repository.addUser(payload);
}

class EditManageCsUserUseCase {
  const EditManageCsUserUseCase(this._repository);
  final ManageCsRepository _repository;
  Future<Either<String, void>> call(Map<String, dynamic> payload) =>
      _repository.editUser(payload);
}

class DeleteManageCsUserUseCase {
  const DeleteManageCsUserUseCase(this._repository);
  final ManageCsRepository _repository;
  Future<Either<String, void>> call({
    required String loginId,
    required String deletedBy,
  }) =>
      _repository.deleteUser(loginId: loginId, deletedBy: deletedBy);
}

class ResetManageCsPasswordUseCase {
  const ResetManageCsPasswordUseCase(this._repository);
  final ManageCsRepository _repository;
  Future<Either<String, void>> call(Map<String, dynamic> payload) =>
      _repository.resetPassword(payload);
}
