import 'package:dartz/dartz.dart';
import '../../data/models/approve_opening_account_model.dart';
import '../repositories/approve_opening_repository.dart';

class GetOpeningAccountsUseCase {
  const GetOpeningAccountsUseCase(this._repository);
  final ApproveOpeningRepository _repository;
  Future<Either<String, List<ApproveOpeningAccountModel>>> call({
    int page = 1,
    int size = 10,
    String? custId,
    String? loginId,
  }) => _repository.fetchAccounts(page: page, size: size, custId: custId, loginId: loginId);
}

class GetOpeningAccountSuggestionsUseCase {
  const GetOpeningAccountSuggestionsUseCase(this._repository);
  final ApproveOpeningRepository _repository;
  Future<Either<String, List<ApproveOpeningAccountModel>>> call() =>
      _repository.fetchSuggestions();
}

class SendOpeningAccountEmailUseCase {
  const SendOpeningAccountEmailUseCase(this._repository);
  final ApproveOpeningRepository _repository;
  Future<Either<String, void>> call(Map<String, dynamic> payload) =>
      _repository.sendEmail(payload);
}
