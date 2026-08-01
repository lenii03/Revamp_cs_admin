import 'package:dartz/dartz.dart';
import 'package:el_csadmin/features/online/online_id/data/models/online_id_model.dart';

abstract class OnlineIdRepository {
  Future<Either<String, List<OnlineIdModel>>> fetchOnlineIds({
    String? search,
    int? page,
    int? size,
  });
  Future<Either<String, String>> addOnlineUser1(Map<String, dynamic> payload);
  Future<Either<String, String>> resetPasswordOrPin(
    Map<String, dynamic> payload,
  );
  Future<Either<String, String>> deleteOnlineId(Map<String, dynamic> payload);
}
