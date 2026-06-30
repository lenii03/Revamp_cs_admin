import 'package:dartz/dartz.dart';
import '../../../../data/repositories/login_repository.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final LoginRepository loginRepository;

  AuthRepositoryImpl({required this.loginRepository});

  @override
  Future<Either<String, LoginUserModel>> login(
    String username,
    String password,
  ) 
  async {
    final Map<String, dynamic> form = {
      "LoginId": username,
      "Password": password,
    };

    print("🚀 Meneruskan proses login ke LoginRepository...");
    return await loginRepository.login(form);
  }
}