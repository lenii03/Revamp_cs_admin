import 'package:dartz/dartz.dart';
import '../../data/models/online_id_model.dart';
import '../repositories/online_id_repository.dart';

class GetOnlineIdsUseCase {
  const GetOnlineIdsUseCase(this._repository);
  final OnlineIdRepository _repository;
  Future<Either<String, List<OnlineIdModel>>> call({
    String? search,
    int? page,
    int? size,
  }) =>
      _repository.fetchOnlineIds(search: search, page: page, size: size);
}

class SaveOnlineIdUseCase {
  const SaveOnlineIdUseCase(this._repository);
  final OnlineIdRepository _repository;
  Future<Either<String, String>> call(Map<String, dynamic> payload) =>
      _repository.addOnlineUser1(payload);
}

class ResetOnlineIdUseCase {
  const ResetOnlineIdUseCase(this._repository);
  final OnlineIdRepository _repository;
  Future<Either<String, String>> call(Map<String, dynamic> payload) =>
      _repository.resetPasswordOrPin(payload);
}
