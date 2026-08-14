import 'package:dartz/dartz.dart';
import 'package:el_csadmin/features/online/online_id/data/models/online_id_model.dart';
import 'package:el_csadmin/features/online/online_id/data/models/account_link_model.dart';
import 'package:el_csadmin/features/online/online_id/data/repositories/online_id_repository.dart';
import 'package:el_csadmin/shared/features/api_datafeed/data/datasources/api_datafeed_network_data_source.dart';

class OnlineIdRepositoryImpl implements OnlineIdRepository {
  final ApiDatafeedNetworkDataSource _networkDataSource;
  List<AccountLinkModel>? _accountLinksCache;

  OnlineIdRepositoryImpl(this._networkDataSource);

  @override
  Future<Either<String, List<OnlineIdModel>>> fetchOnlineIds({
    String? search,
    int? page,
    int? size,
  }) async {
    try {
      final result = await _networkDataSource.fetchOnlineIds(
        search: search,
        page: page,
        size: size,
      );
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> addOnlineUser1(
    Map<String, dynamic> payload,
  ) async {
    try {
      final result = await _networkDataSource.postAddOnlineUser(payload);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<AccountLinkModel>>> fetchAccountLinks() async {
    try {
      final cached = _accountLinksCache;
      if (cached != null) return Right(List.unmodifiable(cached));

      final data = await _networkDataSource.fetchAccountLinks();
      _accountLinksCache = List.of(data);
      return Right(List.unmodifiable(data));
    } catch (e) {
      return Left(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  @override
  Future<Either<String, List<AccountLinkModel>>> fetchLinkedAccounts(
    String loginId,
  ) async {
    try {
      return Right(await _networkDataSource.fetchLinkedAccounts(loginId));
    } catch (e) {
      return Left(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  @override
  Future<Either<String, String>> deleteOnlineId(
    Map<String, dynamic> payload,
  ) async {
    try {
      payload['ActionType'] = 3;
      final result = await _networkDataSource.postAddOnlineUser(payload);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> resetPasswordOrPin(
    Map<String, dynamic> payload,
  ) async {
    try {
      final result = await _networkDataSource.resetOnlinePasswordOrPin(payload);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
