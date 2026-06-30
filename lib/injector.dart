import 'package:el_csadmin/features/cs/cs_logs/presentation/bloc/cs_logs_bloc.dart';
import 'package:el_csadmin/features/online/online_id/presentation/bloc/online_id_bloc.dart';
import 'package:get_it/get_it.dart';
import 'data/local/session_service.dart';
import 'data/remote/dio_client.dart';
import 'data/repositories/login_repository.dart';
import 'features/online/approval/presentation/bloc/approval_state.dart';
import 'features/authentication/domain/repositories/auth_repository.dart';
import 'features/authentication/domain/repositories/auth_repository_impl.dart';
import 'features/authentication/presentation/bloc/authentication_bloc.dart';
import 'features/cs/manage_cs/presentation/bloc/manage_cs_bloc.dart';
import 'shared/features/api_datafeed/data/datasources/api_datafeed_network_data_source.dart';
import 'shared/features/api_datafeed/domain/repositories/api_datafeed_repository.dart';
import 'shared/features/api_datafeed/domain/repositories/api_datafeed_repository_impl.dart';

final locator = GetIt.instance;
Future<void> setupLocator() async {
  final sessionService = SessionService();
  await sessionService.init("cs_admin_session");
  locator.registerSingleton<SessionService>(sessionService);
  final dioClient = DioClient();
  await dioClient.init();
  locator.registerSingleton<DioClient>(dioClient);

  locator.registerLazySingleton<LoginRepository>(() => LoginRepository());
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(loginRepository: locator<LoginRepository>()),
  );

  locator.registerLazySingleton<ApiDatafeedNetworkDataSource>(
    () => ApiDatafeedNetworkDataSourceImpl(locator<DioClient>().dio),
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
