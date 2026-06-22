import 'package:dio/dio.dart';
import 'package:el_csadmin/core/network/dio_interceptor.dart';
import 'package:el_csadmin/features/approval/presentation/bloc/approval_state.dart';
import 'package:el_csadmin/features/authentication/domain/repositories/auth_repository_impl.dart';
import 'package:el_csadmin/features/cs_logs/presentation/bloc/cs_logs_bloc.dart';
import 'package:el_csadmin/features/manage_cs/presentation/bloc/manage_cs_bloc.dart';
import 'package:el_csadmin/features/online/presentation/bloc/online_id_bloc.dart';
import 'package:el_csadmin/shared/features/api_datafeed/data/datasources/api_datafeed_network_data_source.dart';
import 'package:el_csadmin/shared/features/api_datafeed/domain/repositories/api_datafeed_repository.dart';
import 'package:el_csadmin/shared/features/api_datafeed/domain/repositories/api_datafeed_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:el_csadmin/features/authentication/domain/repositories/auth_repository.dart';
import 'package:el_csadmin/features/authentication/presentation/bloc/authentication_bloc.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<Dio>(() {
    final dio = Dio();
    dio.interceptors.add(DioInterceptor());
    return dio;
  });
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(dio: locator<Dio>()),
  );
  locator.registerLazySingleton<ApiDatafeedNetworkDataSource>(
    // Jika mau nembak API asli, nyalakan yang ini:
    // () => ApiDatafeedNetworkDataSourceImpl(locator<Dio>()),

    // Karena kita mau test UI dulu, kita pakai MOCK:
    () => const ApiDatafeedNetworkDataSourceMockImpl(),
  );
  locator.registerFactory<AuthenticationBloc>(
    () => AuthenticationBloc(authRepository: locator<AuthRepository>()),
  );
  locator.registerLazySingleton<ApiDatafeedRepository>(
    () => ApiDatafeedRepositoryImpl(locator<ApiDatafeedNetworkDataSource>()),
  );
  locator.registerFactory<ManageCsBloc>(
    () => ManageCsBloc(repository: locator<ApiDatafeedRepository>()),
  );
  locator.registerFactory<CsLogsBloc>(
    () => CsLogsBloc(repository: locator<ApiDatafeedRepository>()),
  );
  locator.registerFactory<OnlineIdBloc>(
    () => OnlineIdBloc(repository: locator<ApiDatafeedRepository>()),
  );
  locator.registerFactory<ApprovalScreenBloc>(
    () => ApprovalScreenBloc(repository: locator<ApiDatafeedRepository>()),
  );
}
