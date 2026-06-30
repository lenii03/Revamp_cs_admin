import 'package:dartz/dartz.dart';
import '../../../../data/repositories/login_repository.dart';

abstract class AuthRepository {
  Future<Either<String, LoginUserModel>> login(
    String username,
    String password,
  );
}
