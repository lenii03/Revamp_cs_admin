import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:el_csadmin/features/authentication/data/models/user_model.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../../core/network/token_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio dio;

  AuthRepositoryImpl({required this.dio});

  @override
  Future<Either<String, LoginUserModel>> login(
    String username,
    String password,
  ) async {
    try {
      // 1. KITA KUNCI ALAMATNYA SECARA PAKSA (HARDCODE) SESUAI APLIKASI LAMA
      const String exactUrl = 'http://115.85.84.52:9001/csAdmin/cs/login';

      final Map<String, dynamic> form = {
        "LoginId": username,
        "Password": password,
      };

      print("🚀 MENGIRIM LOGIN (HARDCODE) KE: $exactUrl");

      // 2. KITA TEMBAK LANGSUNG BESERTA "SERAGAM" HEADERS-NYA
      final response = await dio.post(
        exactUrl,
        data: jsonEncode(form),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': '*/*',
            'Authorization':
                'Bearer -', // Memaksa format yang sama dengan kode lamamu
          },
        ),
      );

      print("✅ BERHASIL MASUK! BALASAN SERVER: ${response.data}");

      final Map<String, dynamic> data = response.data['data'] ?? {};

      if (data.isNotEmpty) {
        final String token = data['Token'] ?? '';
        if (token.isNotEmpty) await TokenService.saveToken(token);

        return Right(LoginUserModel.fromMap(data));
      } else {
        return const Left("Data kosong dari server");
      }
    } on DioException catch (e) {
      print("❌ GAGAL DIO! STATUS: ${e.response?.statusCode}");
      print("❌ PESAN SERVER: ${e.response?.data}");
      return Left("Gagal Login. Status: ${e.response?.statusCode}");
    } catch (e) {
      print("❌ ERROR LAIN: $e");
      return Left(e.toString());
    }
  }
}
