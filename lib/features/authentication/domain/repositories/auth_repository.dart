import 'package:dartz/dartz.dart';
import 'package:el_csadmin/features/authentication/data/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<String, LoginUserModel>> login(
    String username,
    String password,
  );
}
