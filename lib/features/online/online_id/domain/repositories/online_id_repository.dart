import 'package:dartz/dartz.dart';
import '../../data/models/account_link_model.dart';
import '../../data/models/online_id_model.dart';

abstract class OnlineIdRepository {
  Future<Either<String, List<OnlineIdModel>>> fetchOnlineIds({
    String? search,
    int? page,
    int? size,
  });
  Future<Either<String, String>> addOnlineUser1(Map<String, dynamic> payload);
  Future<Either<String, List<AccountLinkModel>>> fetchAccountLinks();
  Future<Either<String, List<AccountLinkModel>>> fetchLinkedAccounts(
    String loginId,
  );
  Future<Either<String, String>> resetPasswordOrPin(
    Map<String, dynamic> payload,
  );
  Future<Either<String, String>> deleteOnlineId(Map<String, dynamic> payload);
}
