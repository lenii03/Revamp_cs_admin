import 'package:el_csadmin/features/auto_update/data/repositories/auto_update_repository_impl.dart';
import 'package:el_csadmin/features/auto_update/domain/repositories/auto_update_repository.dart';
import 'package:el_csadmin/features/auto_update/presentation/bloc/auto_update_bloc.dart';
import 'package:el_csadmin/features/cs/cs_logs/presentation/bloc/cs_logs_bloc.dart';
import 'package:el_csadmin/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:el_csadmin/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:el_csadmin/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:el_csadmin/features/dashboard/domain/usecases/get_dashboard_metrics_usecase.dart';
import 'package:el_csadmin/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:el_csadmin/features/online/approval/presentation/bloc/approval_bloc.dart';
import 'package:el_csadmin/features/online/approval/data/datasources/approval_remote_data_source.dart';
import 'package:el_csadmin/features/online/approval/data/repositories/approval_repository_impl.dart';
import 'package:el_csadmin/features/online/approval/domain/repositories/approval_repository.dart';
import 'package:el_csadmin/features/online/approval/domain/usecases/approval_usecases.dart';
import 'package:el_csadmin/features/online/online_id/data/repositories/online_id_repository_impl.dart';
import 'package:el_csadmin/features/online/online_id/data/datasources/online_id_remote_data_source.dart';
import 'package:el_csadmin/features/online/online_id/domain/repositories/online_id_repository.dart';
import 'package:el_csadmin/features/online/online_id/domain/usecases/online_id_usecases.dart';
import 'package:el_csadmin/features/online/online_id/presentation/bloc/online_id_bloc.dart';
import 'package:el_csadmin/features/user_communication/approve_opening/presentation/bloc/approve_opening_bloc.dart';
import 'package:el_csadmin/features/user_communication/approve_opening/data/datasources/approve_opening_remote_data_source.dart';
import 'package:el_csadmin/features/user_communication/approve_opening/data/repositories/approve_opening_repository_impl.dart';
import 'package:el_csadmin/features/user_communication/approve_opening/domain/repositories/approve_opening_repository.dart';
import 'package:el_csadmin/features/user_communication/approve_opening/domain/usecases/approve_opening_usecases.dart';
import 'package:el_csadmin/features/user_communication/notification/presentation/bloc/notification_bloc.dart';
import 'package:el_csadmin/features/user_communication/notification/data/datasources/notification_remote_data_source.dart';
import 'package:el_csadmin/features/user_communication/notification/data/repositories/notification_repository_impl.dart';
import 'package:el_csadmin/features/user_communication/notification/domain/repositories/notification_repository.dart';
import 'package:el_csadmin/features/user_communication/notification/domain/usecases/notification_usecases.dart';
import 'package:el_csadmin/features/user_communication/send_email/presentation/bloc/send_email_bloc.dart';
import 'package:el_csadmin/features/user_communication/send_email/data/repositories/send_email_queue_repository.dart';
import 'package:get_it/get_it.dart';
import 'data/local/session_service.dart';
import 'data/remote/dio_client.dart';
import 'data/repositories/login_repository.dart';
import 'features/authentication/domain/repositories/auth_repository.dart';
import 'features/authentication/domain/repositories/auth_repository_impl.dart';
import 'features/authentication/presentation/bloc/authentication_bloc.dart';
import 'features/cs/manage_cs/data/datasources/manage_cs_remote_data_source.dart';
import 'features/cs/manage_cs/data/repositories/manage_cs_repository_impl.dart';
import 'features/cs/manage_cs/domain/repositories/manage_cs_repository.dart';
import 'features/cs/manage_cs/domain/usecases/manage_cs_usecases.dart';
import 'features/cs/manage_cs/presentation/bloc/manage_cs_bloc.dart';
import 'features/cs/cs_logs/data/datasources/cs_logs_remote_data_source.dart';
import 'features/cs/cs_logs/data/repositories/cs_logs_repository_impl.dart';
import 'features/cs/cs_logs/domain/repositories/cs_logs_repository.dart';
import 'features/cs/cs_logs/domain/usecases/get_cs_logs_usecase.dart';
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
  locator.registerLazySingleton<ManageCsRemoteDataSourceImpl>(
    () => ManageCsRemoteDataSourceImpl(locator<DioClient>()),
  );
  locator.registerLazySingleton<CsLogsRemoteDataSourceImpl>(
    () => CsLogsRemoteDataSourceImpl(locator<DioClient>()),
  );
  locator.registerLazySingleton<OnlineIdRemoteDataSourceImpl>(
    () => OnlineIdRemoteDataSourceImpl(locator<DioClient>()),
  );
  locator.registerLazySingleton<ApprovalRemoteDataSourceImpl>(
    () => ApprovalRemoteDataSourceImpl(locator<DioClient>()),
  );
  locator.registerLazySingleton<ApproveOpeningRemoteDataSourceImpl>(
    () => ApproveOpeningRemoteDataSourceImpl(locator<DioClient>()),
  );
  locator.registerLazySingleton<NotificationRemoteDataSourceImpl>(
    () => NotificationRemoteDataSourceImpl(locator<DioClient>()),
  );
  locator.registerLazySingleton<DashboardRemoteDataSourceImpl>(
    () => DashboardRemoteDataSourceImpl(locator<DioClient>()),
  );

  locator.registerLazySingleton<ApiDatafeedNetworkDataSource>(
    () => ApiDatafeedNetworkDataSourceImpl(locator<DioClient>()),
  );
  locator.registerLazySingleton<ApiDatafeedNetworkDataSourceMockImpl>(
    () => const ApiDatafeedNetworkDataSourceMockImpl(),
  );
  locator.registerLazySingleton<ApiDatafeedRepository>(
    () => ApiDatafeedRepositoryImpl(locator<ApiDatafeedNetworkDataSource>()),
  );

  locator.registerLazySingleton<LoginRepository>(() => LoginRepository());
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(loginRepository: locator<LoginRepository>()),
  );

  locator.registerFactory<AuthenticationBloc>(
    () => AuthenticationBloc(authRepository: locator<AuthRepository>()),
  );
  locator.registerLazySingleton<DashboardRemoteDataSource>(
    () => locator<DashboardRemoteDataSourceImpl>(),
  );
  locator.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(locator<DashboardRemoteDataSource>()),
  );
  locator.registerLazySingleton(
    () => GetDashboardMetricsUseCase(locator<DashboardRepository>()),
  );
  locator.registerFactory<DashboardBloc>(
    () => DashboardBloc(getMetrics: locator<GetDashboardMetricsUseCase>()),
  );
  locator.registerLazySingleton<SendEmailQueueRepository>(
    () => SendEmailQueueRepository(locator<SessionService>()),
  );

  locator.registerLazySingleton<ManageCsRemoteDataSource>(
    () => locator<ManageCsRemoteDataSourceImpl>(),
  );
  locator.registerLazySingleton<ManageCsRepository>(
    () => ManageCsRepositoryImpl(locator<ManageCsRemoteDataSource>()),
  );
  locator.registerLazySingleton(
    () => GetManageCsUsersUseCase(locator<ManageCsRepository>()),
  );
  locator.registerLazySingleton(
    () => AddManageCsUserUseCase(locator<ManageCsRepository>()),
  );
  locator.registerLazySingleton(
    () => EditManageCsUserUseCase(locator<ManageCsRepository>()),
  );
  locator.registerLazySingleton(
    () => DeleteManageCsUserUseCase(locator<ManageCsRepository>()),
  );
  locator.registerLazySingleton(
    () => ResetManageCsPasswordUseCase(locator<ManageCsRepository>()),
  );
  locator.registerFactory<ManageCsBloc>(
    () => ManageCsBloc(
      getUsers: locator<GetManageCsUsersUseCase>(),
      addUser: locator<AddManageCsUserUseCase>(),
      editUser: locator<EditManageCsUserUseCase>(),
      deleteUser: locator<DeleteManageCsUserUseCase>(),
      resetPassword: locator<ResetManageCsPasswordUseCase>(),
    ),
  );

  locator.registerLazySingleton<CsLogsRemoteDataSource>(
    () => locator<CsLogsRemoteDataSourceImpl>(),
  );
  locator.registerLazySingleton<CsLogsRepository>(
    () => CsLogsRepositoryImpl(locator<CsLogsRemoteDataSource>()),
  );
  locator.registerLazySingleton(
    () => GetCsLogsUseCase(locator<CsLogsRepository>()),
  );
  locator.registerFactory<CsLogsBloc>(
    () => CsLogsBloc(getLogs: locator<GetCsLogsUseCase>()),
  );

  locator.registerLazySingleton<OnlineIdRepository>(
    () => OnlineIdRepositoryImpl(locator<OnlineIdRemoteDataSource>()),
  );
  locator.registerLazySingleton<OnlineIdRemoteDataSource>(
    () => locator<OnlineIdRemoteDataSourceImpl>(),
  );
  locator.registerLazySingleton(
    () => GetOnlineIdsUseCase(locator<OnlineIdRepository>()),
  );
  locator.registerLazySingleton(
    () => SaveOnlineIdUseCase(locator<OnlineIdRepository>()),
  );
  locator.registerLazySingleton(
    () => ResetOnlineIdUseCase(locator<OnlineIdRepository>()),
  );

  locator.registerFactory<OnlineIdBloc>(
    () => OnlineIdBloc(
      getOnlineIds: locator<GetOnlineIdsUseCase>(),
      saveOnlineId: locator<SaveOnlineIdUseCase>(),
      resetOnlineId: locator<ResetOnlineIdUseCase>(),
      sessionService: locator<SessionService>(),
      queueRepository: locator<SendEmailQueueRepository>(),
    ),
  );
  locator.registerLazySingleton<ApprovalRemoteDataSource>(
    () => locator<ApprovalRemoteDataSourceImpl>(),
  );
  locator.registerLazySingleton<ApprovalRepository>(
    () => ApprovalRepositoryImpl(locator<ApprovalRemoteDataSource>()),
  );
  locator.registerLazySingleton(
    () => GetApprovalsUseCase(locator<ApprovalRepository>()),
  );
  locator.registerLazySingleton(
    () => UpdateApprovalStatusUseCase(locator<ApprovalRepository>()),
  );
  locator.registerLazySingleton(
    () => GetApprovalLinkedAccountsDetailUseCase(locator<ApprovalRepository>()),
  );
  locator.registerFactory<ApprovalScreenBloc>(
    () => ApprovalScreenBloc(
      getApprovals: locator<GetApprovalsUseCase>(),
      updateApprovalStatus: locator<UpdateApprovalStatusUseCase>(),
      getLinkedAccountsDetail:
          locator<GetApprovalLinkedAccountsDetailUseCase>(),
      sessionService: locator<SessionService>(),
    ),
  );
  locator.registerFactory(
    () => SendEmailForgotBloc(
      queueRepository: locator<SendEmailQueueRepository>(),
    ),
  );
  locator.registerLazySingleton<ApproveOpeningRemoteDataSource>(
    () => locator<ApproveOpeningRemoteDataSourceImpl>(),
  );
  locator.registerLazySingleton<ApproveOpeningRepository>(
    () =>
        ApproveOpeningRepositoryImpl(locator<ApproveOpeningRemoteDataSource>()),
  );
  locator.registerLazySingleton(
    () => GetOpeningAccountsUseCase(locator<ApproveOpeningRepository>()),
  );
  locator.registerLazySingleton(
    () => GetOpeningAccountSuggestionsUseCase(
      locator<ApproveOpeningRepository>(),
    ),
  );
  locator.registerLazySingleton(
    () => SendOpeningAccountEmailUseCase(locator<ApproveOpeningRepository>()),
  );
  locator.registerFactory<ApproveOpeningBloc>(
    () => ApproveOpeningBloc(
      getAccounts: locator<GetOpeningAccountsUseCase>(),
      sendEmail: locator<SendOpeningAccountEmailUseCase>(),
      sessionService: locator<SessionService>(),
    ),
  );
  locator.registerLazySingleton<NotificationRemoteDataSource>(
    () => locator<NotificationRemoteDataSourceImpl>(),
  );
  locator.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(locator<NotificationRemoteDataSource>()),
  );
  locator.registerLazySingleton(
    () => GetSchedulersUseCase(locator<NotificationRepository>()),
  );
  locator.registerLazySingleton(
    () => CreateSchedulerUseCase(locator<NotificationRepository>()),
  );
  locator.registerFactory<NotificationBloc>(
    () => NotificationBloc(
      getSchedulers: locator<GetSchedulersUseCase>(),
      createScheduler: locator<CreateSchedulerUseCase>(),
    ),
  );
  locator.registerLazySingleton<AutoUpdateRepository>(
    () => const AutoUpdateRepositoryImpl(),
  );
  locator.registerFactory(() => AutoUpdateBloc(repository: locator()));
}
