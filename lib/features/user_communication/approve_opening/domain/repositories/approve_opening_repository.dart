import 'package:dartz/dartz.dart';
import '../../data/models/approve_opening_account_model.dart';

abstract class ApproveOpeningRepository {
  Future<Either<String, List<ApproveOpeningAccountModel>>> fetchAccounts({
    int page = 1,
    int size = 10,
    String? custId,
    String? loginId,
  });
  Future<Either<String, List<ApproveOpeningAccountModel>>> fetchSuggestions();
  Future<Either<String, void>> sendEmail(Map<String, dynamic> payload);
}
