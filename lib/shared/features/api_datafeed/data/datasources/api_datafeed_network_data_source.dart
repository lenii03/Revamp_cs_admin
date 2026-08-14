import 'package:dio/dio.dart';
import 'package:el_csadmin/features/cs/cs_logs/data/models/cs_log_model.dart';
import 'package:el_csadmin/features/online/approval/data/models/link_account_model.dart';
import 'package:el_csadmin/features/online/online_id/data/models/online_id_model.dart';
import 'package:el_csadmin/features/online/online_id/data/models/account_link_model.dart';
import 'package:el_csadmin/features/user_communication/send_email/data/models/send_email_forgot_model.dart';
import '../../../../../core/constants/endpoint.dart';
import '../../../../../core/network/server_config.dart';
import '../../../../../features/online/approval/data/models/approval_screen_model.dart';
import '../../../../../features/cs/manage_cs/data/models/cs_user_model.dart';
import '../../../../../features/reports/reset_password_report/data/models/reset_password_report_model.dart';

abstract class ApiDatafeedNetworkDataSource {
  Future<List<ManageCsUsersModel>> fetchCsList();
  Future<List<CsLogModel>> fetchCsLogs({
    String? loginId,
    String? targetId,
    int? logType,
    int? page,
    int? size,
  });
  Future<List<OnlineIdModel>> fetchOnlineIds({
    String? search,
    int? page,
    int? size,
  });
  Future<List<ApprovalScreenModel>> fetchApprovals({
    String? search,
    int? actionType,
    int? status,
    int page = 1,
    int size = 30,
  });
  Future<Map<String, dynamic>> fetchLinkedAccountsDetail(
    String loginId,
    String approvalId,
  );
  // Future<List<ResetPasswordReportModel>> fetchResetPasswordReports();
  Future<void> addCsUser(Map<String, dynamic> requestData);
  Future<void> deleteCsUser(String loginId);
  Future<void> editCsUser(Map<String, dynamic> requestData);
  Future<void> resetPassword(Map<String, dynamic> requestData);
  Future<void> sendEmailForgotPinPassword(
    String loginId,
    int actionType,
    String csLoginId,
  );
  Future<List<SendEmailForgotModel>> fetchSendEmailForgotList();
  Future<List<dynamic>> fetchOpeningAccounts({
    int page = 1,
    int size = 10,
    String? custId,
    String? loginId,
  });
  Future<List<dynamic>> fetchOpeningAccountSuggestions();
  Future<void> sendEmailOpeningAccount(Map<String, dynamic> payload);
  Future<List<dynamic>> fetchSchedulerNotifications({
    int page = 1,
    int size = 10,
  });
  Future<void> sendPushNotification(Map<String, dynamic> payload);
  Future<void> createSchedulerNotification(Map<String, dynamic> payload);
  Future<String> postAddOnlineUser(Map<String, dynamic> payload);
  Future<List<AccountLinkModel>> fetchAccountLinks();
  Future<List<AccountLinkModel>> fetchLinkedAccounts(String loginId);
  Future<String> resetOnlinePasswordOrPin(Map<String, dynamic> payload);

  Future<void> updateApprovalStatus(Map<String, dynamic> payload) async {}
}

class CsUserModel {}

// 2. IMPLEMENTASI REAL API
class ApiDatafeedNetworkDataSourceImpl implements ApiDatafeedNetworkDataSource {
  final Dio dio;
  const ApiDatafeedNetworkDataSourceImpl(this.dio);

  @override
  Future<List<ManageCsUsersModel>> fetchCsList() async {
    final baseUrl = await ServerConfig.getBaseUrl();
    if (baseUrl.isEmpty) throw Exception('IP Server belum dikonfigurasi.');
    dio.options.baseUrl = baseUrl;

    final response = await dio.get(
      Endpoint.getCSList,
      queryParameters: {"page": 1, "size": 30},
    );
    final List<dynamic> responseData = response.data['data'] ?? [];
    return responseData
        .map((item) => ManageCsUsersModel.fromMap(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<CsLogModel>> fetchCsLogs({
    String? loginId,
    String? targetId,
    int? logType,
    int? page,
    int? size,
  }) async {
    final baseUrl = await ServerConfig.getBaseUrl();
    if (baseUrl.isEmpty) throw Exception('IP Server belum dikonfigurasi.');
    dio.options.baseUrl = baseUrl;

    final queryParams = <String, dynamic>{
      "page": page ?? 1,
      "size": size ?? 30,
    };

    if (loginId != null && loginId.isNotEmpty) {
      queryParams["csLoginId"] = loginId;
    }
    if (targetId != null && targetId.isNotEmpty) {
      queryParams["loginId"] = targetId;
    }
    if (logType != null && logType != -1) {
      queryParams["logType"] = logType;
    }

    final response = await dio.get(
      Endpoint.getCsLogs,
      queryParameters: queryParams,
    );

    final List<dynamic> responseData = response.data['data'] ?? [];
    return responseData
        .map((item) => CsLogModel.fromMap(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<OnlineIdModel>> fetchOnlineIds({
    String? search,
    int? page,
    int? size,
  }) async {
    final baseUrl = await ServerConfig.getBaseUrl();
    if (baseUrl.isEmpty) throw Exception('IP Server belum dikonfigurasi.');
    dio.options.baseUrl = baseUrl;

    final queryParams = <String, dynamic>{
      "page": page ?? 1,
      "size": size ?? 30,
    };

    if (search != null && search.isNotEmpty) {
      final normalizedSearch = search.trim();
      final separatorIndex = normalizedSearch.indexOf(' - ');
      if (separatorIndex >= 0) {
        queryParams["loginId"] = normalizedSearch
            .substring(0, separatorIndex)
            .trim();
        queryParams["email"] = normalizedSearch
            .substring(separatorIndex + 3)
            .trim();
      } else if (normalizedSearch.contains('@')) {
        queryParams["email"] = normalizedSearch;
      } else {
        queryParams["loginId"] = normalizedSearch;
      }
    }

    final response = await dio.get(
      Endpoint.getOnlineUser,
      queryParameters: queryParams,
    );

    final List<dynamic> responseData = response.data['data'] ?? [];
    return responseData
        .map((item) => OnlineIdModel.fromMap(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<ApprovalScreenModel>> fetchApprovals({
    String? search,
    int? actionType,
    int? status,
    int page = 1,
    int size = 30,
  }) async {
    final baseUrl = await ServerConfig.getBaseUrl();
    if (baseUrl.isEmpty) throw Exception('IP Server belum dikonfigurasi.');
    dio.options.baseUrl = baseUrl;
    final query = <String, dynamic>{"page": page, "size": size};
    if (actionType != null) query['actionType'] = actionType;
    if (status != null) query['status'] = status;
    final normalizedSearch = search?.trim() ?? '';
    if (normalizedSearch.isNotEmpty) {
      final parts = normalizedSearch.split(' - ');
      query['loginId'] = parts.first.trim();
      if (parts.length > 1) {
        query['createdBy'] = parts.skip(1).join(' - ').trim();
      }
    }
    final response = await dio.get(
      Endpoint.getApprovalList,
      queryParameters: query,
    );

    final List<dynamic> responseData = response.data['data'] ?? [];
    return responseData
        .map(
          (item) => ApprovalScreenModel.fromMap(item as Map<String, dynamic>),
        )
        .toList();
  }

  Future<Map<String, dynamic>> fetchLinkedAccountsDetail(
    String loginId,
    String approvalId,
  ) async {
    final baseUrl = await ServerConfig.getBaseUrl();
    dio.options.baseUrl = baseUrl;

    List<LinkAccountInfoModel> oldLinks = [];
    List<NewLinkAccountInfoModel> newLinks = [];
    try {
      final responseOld = await dio.get(
        Endpoint.getLinkedInfoAccount,
        queryParameters: {'loginId': loginId},
      );
      final List<dynamic> rawOldLinks = responseOld.data['data'] ?? [];
      oldLinks = rawOldLinks
          .map((e) => LinkAccountInfoModel.fromMap(e))
          .toList();
    } catch (e) {
      print("ERROR FETCH OLD LINK: $e");
    }
    try {
      final responseNew = await dio.get(
        Endpoint.getLinkedInfoAccountApproval,
        queryParameters: {'approvalId': approvalId},
      );
      final List<dynamic> rawNewLinks =
          responseNew.data['data'] ?? responseNew.data['List'] ?? [];
      newLinks = rawNewLinks
          .map((e) => NewLinkAccountInfoModel.fromMap(e))
          .toList();
    } catch (e) {
      print("ERROR FETCH NEW LINK (Approval): $e");
    }

    return {'old': oldLinks, 'new': newLinks};
  }

  @override
  Future<List<ResetPasswordReportModel>> fetchResetPasswordReports() {
    // TODO: implement fetchResetPasswordReports
    throw UnimplementedError();
  }

  @override
  Future<void> addCsUser(Map<String, dynamic> requestData) async {
    final baseUrl = await ServerConfig.getBaseUrl();
    if (baseUrl.isEmpty) throw Exception('IP Server belum dikonfigurasi.');
    dio.options.baseUrl = baseUrl;
    final response = await dio.post(Endpoint.postAddCs, data: requestData);
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response.data['message'] ?? 'Gagal menambahkan CS');
    }
  }

  @override
  Future<void> deleteCsUser(String loginId) async {
    await dio.delete(
      Endpoint.deleteCs,
      queryParameters: {'loginId': loginId, 'deletedBy': 'admin'},
    );
  }

  @override
  Future<void> editCsUser(Map<String, dynamic> requestData) async {
    await dio.put(Endpoint.putEditCs, data: requestData);
  }

  @override
  Future<void> resetPassword(Map<String, dynamic> requestData) async {
    await dio.put(Endpoint.putResetPw, data: requestData);
  }

  @override
  Future<void> sendEmailForgotPinPassword(
    String loginId,
    int actionType,
    String csLoginId,
  ) async {
    final baseUrl = await ServerConfig.getBaseUrl();
    if (baseUrl.isEmpty) throw Exception('IP Server belum dikonfigurasi.');
    dio.options.baseUrl = baseUrl;

    try {
      final response = await dio.post(
        Endpoint.sendEmailPINAndPasswordOnlineUser,
        data: {
          "LoginId": loginId,
          "ActionType": actionType,
          "CSLoginId": csLoginId,
        },
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        final responseData = response.data;
        throw Exception(
          responseData is Map
              ? responseData['message'] ?? 'Gagal mengirim email'
              : 'Gagal mengirim email',
        );
      }
    } on DioException catch (e) {
      final responseData = e.response?.data;
      final message = responseData is Map
          ? responseData['message']?.toString()
          : null;
      throw Exception(message ?? e.message ?? 'Gagal mengirim email');
    }
  }

  @override
  Future<List<SendEmailForgotModel>> fetchSendEmailForgotList() async {
    throw UnimplementedError('API GET Send Email Forgot belum tersedia');
  }

  @override
  Future<List<dynamic>> fetchOpeningAccounts({
    int page = 1,
    int size = 10,
    String? custId,
    String? loginId,
  }) async {
    try {
      final baseUrl = await ServerConfig.getBaseUrl();
      if (baseUrl.isEmpty) throw Exception('IP Server belum dikonfigurasi.');
      dio.options.baseUrl = baseUrl;
      final response = await dio.get(
        Endpoint.getListOpeningAccount,
        queryParameters: {
          'page': page,
          'size': size,
          if (custId != null && custId.isNotEmpty) 'custId': custId,
          if (loginId != null && loginId.isNotEmpty) 'loginId': loginId,
        },
      );

      if (response.statusCode == 200) {
        return response.data['data'] as List<dynamic>;
      } else {
        throw Exception(
          response.data['message'] ?? 'Gagal memuat data Opening Accounts',
        );
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan jaringan: ${e.toString()}');
    }
  }

  @override
  Future<List<dynamic>> fetchOpeningAccountSuggestions() async {
    final baseUrl = await ServerConfig.getBaseUrl();
    if (baseUrl.isEmpty) throw Exception('IP Server belum dikonfigurasi.');
    dio.options.baseUrl = baseUrl;
    final response = await dio.get(
      Endpoint.getListOpeningAccountSuggestion,
      queryParameters: const {'custId': '', 'loginId': ''},
    );
    return (response.data['data'] as List<dynamic>?) ?? const [];
  }

  @override
  Future<void> sendEmailOpeningAccount(Map<String, dynamic> payload) async {
    final baseUrl = await ServerConfig.getBaseUrl();
    if (baseUrl.isEmpty) throw Exception('IP Server belum dikonfigurasi.');
    dio.options.baseUrl = baseUrl;

    try {
      final response = await dio.post(
        Endpoint.sendEmailOpeningAccountWithRekening,
        data: payload,
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        final data = response.data;
        throw Exception(
          data is Map
              ? data['message'] ?? 'Gagal mengirim email'
              : 'Gagal mengirim email',
        );
      }
    } on DioException catch (e) {
      final data = e.response?.data;
      throw Exception(
        data is Map
            ? data['message']?.toString() ?? e.message ?? 'Gagal mengirim email'
            : e.message ?? 'Gagal mengirim email',
      );
    }
  }

  @override
  Future<List<dynamic>> fetchSchedulerNotifications({
    int page = 1,
    int size = 10,
  }) async {
    try {
      final response = await dio.get(
        '/cs/get-list-scheduler-notification',
        queryParameters: {'page': page, 'size': size},
      );
      if (response.statusCode == 200) {
        return response.data['data'] as List<dynamic>;
      } else {
        throw Exception(response.data['message'] ?? 'Gagal memuat Scheduler');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan jaringan: ${e.toString()}');
    }
  }

  @override
  Future<void> sendPushNotification(Map<String, dynamic> payload) async {
    final response = await dio.post('/cs/push-notification', data: payload);
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(
        response.data['message'] ?? 'Gagal mengirim push notification',
      );
    }
  }

  @override
  Future<void> createSchedulerNotification(Map<String, dynamic> payload) async {
    final response = await dio.post(
      '/cs/create-scheduler-notification',
      data: payload,
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response.data['message'] ?? 'Gagal membuat scheduler');
    }
  }

  @override
  Future<String> postAddOnlineUser(Map<String, dynamic> payload) async {
    try {
      final baseUrl = await ServerConfig.getBaseUrl();
      if (baseUrl.isEmpty) throw Exception('IP Server belum dikonfigurasi.');
      dio.options.baseUrl = baseUrl;

      final response = await dio.post(Endpoint.postAddOnUser, data: payload);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data['message'] ?? "Berhasil memproses data";
      } else {
        throw Exception(response.data['message'] ?? "Gagal memproses data");
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? "Terjadi kesalahan pada server",
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<AccountLinkModel>> fetchAccountLinks() async {
    try {
      final baseUrl = await ServerConfig.getBaseUrl();
      if (baseUrl.isEmpty) throw Exception('IP Server belum dikonfigurasi.');
      dio.options.baseUrl = baseUrl;

      final response = await dio.get(Endpoint.getAccountLink);
      final body = response.data;
      final rawData = body is Map ? body['data'] : null;
      if (rawData is! List) return const [];

      return rawData
          .whereType<Map>()
          .map(
            (item) => AccountLinkModel.fromMap(
              Map<String, dynamic>.from(item),
            ),
          )
          .where((item) => item.custId.isNotEmpty)
          .toList();
    } on DioException catch (e) {
      final body = e.response?.data;
      final message = body is Map ? body['message']?.toString() : null;
      throw Exception(message ?? 'Gagal mengambil daftar account');
    }
  }

  @override
  Future<List<AccountLinkModel>> fetchLinkedAccounts(String loginId) async {
    try {
      final baseUrl = await ServerConfig.getBaseUrl();
      if (baseUrl.isEmpty) throw Exception('IP Server belum dikonfigurasi.');
      dio.options.baseUrl = baseUrl;

      final response = await dio.get(
        Endpoint.getLinkedInfoAccount,
        queryParameters: {'loginId': loginId},
      );
      final body = response.data;
      final rawData = body is Map ? body['data'] : null;
      if (rawData is! List) return const [];
      return rawData
          .whereType<Map>()
          .map(
            (item) => AccountLinkModel.fromMap(
              Map<String, dynamic>.from(item),
            ),
          )
          .where((item) => item.custId.isNotEmpty)
          .toList();
    } on DioException catch (e) {
      final body = e.response?.data;
      final message = body is Map ? body['message']?.toString() : null;
      throw Exception(message ?? 'Gagal mengambil linked account');
    }
  }

  @override
  Future<String> resetOnlinePasswordOrPin(Map<String, dynamic> payload) async {
    final baseUrl = await ServerConfig.getBaseUrl();
    if (baseUrl.isEmpty) throw Exception('IP Server belum dikonfigurasi.');
    dio.options.baseUrl = baseUrl;

    try {
      final response = await dio.post(Endpoint.resetPWDOrPIN, data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        return responseData is Map
            ? responseData['message']?.toString() ??
                  'Reset Password/PIN berhasil'
            : 'Reset Password/PIN berhasil';
      }

      final responseData = response.data;
      throw Exception(
        responseData is Map
            ? responseData['message'] ?? 'Gagal reset Password/PIN'
            : 'Gagal reset Password/PIN',
      );
    } on DioException catch (e) {
      final responseData = e.response?.data;
      final message = responseData is Map
          ? responseData['message']?.toString()
          : null;
      throw Exception(message ?? e.message ?? 'Gagal reset Password/PIN');
    }
  }

  @override
  Future<void> updateApprovalStatus(Map<String, dynamic> payload) async {
    try {
      final baseUrl = await ServerConfig.getBaseUrl();
      if (baseUrl.isEmpty) throw Exception('IP Server belum dikonfigurasi.');
      dio.options.baseUrl = baseUrl;
      final response = await dio.post(
        Endpoint.updateStatusApprovalUser,
        data: payload,
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(
          response.data['message'] ?? "Gagal memproses data approval",
        );
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? "Terjadi kesalahan pada server",
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

// 3. IMPLEMENTASI MOCK
class ApiDatafeedNetworkDataSourceMockImpl
    implements ApiDatafeedNetworkDataSource {
  const ApiDatafeedNetworkDataSourceMockImpl();

  @override
  Future<List<ManageCsUsersModel>> fetchCsList() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return [
      ManageCsUsersModel(
        loginId: 'admin',
        employeeId: '000001',
        email: 'dayatburgerkill3@gmail.com',
        isActive: true,
        isCs: true,
        isOnline: true,
        permissions: 255,
        created: '2026-06-25',
        lastModified: '-',
        lastLogin: '-',
        createdBy: 'system',
        modifiedBy: '-',
      ),
      ManageCsUsersModel(
        loginId: 'admintest4',
        employeeId: '001',
        email: 'test123@gmail.com',
        isActive: true,
        isCs: true,
        isOnline: true,
        permissions: 0,
        created: '2026-06-26',
        lastModified: '-',
        lastLogin: '-',
        createdBy: 'admin',
        modifiedBy: '-',
      ),
    ];
  }

  @override
  Future<List<CsLogModel>> fetchCsLogs({
    String? loginId,
    String? targetId,
    int? logType,
    int? page,
    int? size,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return [
      CsLogModel(
        csLoginId: 'dimas2',
        onlineLoginId: 'R1534',
        logTime: '16-03-2026 13:57:16',
        approvalId: '10500',
        logType: '6',
        descriptions: 'Create New Online Id',
      ),
      CsLogModel(
        csLoginId: 'dimas2',
        onlineLoginId: 'R1534',
        logTime: '16-03-2026 13:57:16',
        approvalId: '10500',
        logType: '16',
        descriptions: 'Approve Link Account',
      ),
    ];
  }

  @override
  Future<List<OnlineIdModel>> fetchOnlineIds({
    String? search,
    int? page,
    int? size,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return [
      OnlineIdModel(
        loginId: 'mock001',
        email: 'mock@example.com',
        approvedBy: 'admin',
        emailApprovedAt: '-',
        created: '2026-07-01',
        createdBy: 'admin',
        handphoneNo: '08123456789',
        handphone: '08123456789',
        birthDate: '1990-01-01',
        lastAcctLogin: '-',
        lastLogin: '-',
        lastModified: '-',
        lastModifiedBy: '-',
        lastPinChg: '-',
        lastPasswordChg: '-',
        loginType: 1,
        pin: '123456',
        pinExpired: '-',
        password: 'password123',
        permissions: 0,
        pwdExpired: null,
        salesId: 'S001',
        status: 1,
        accountExpired: null,
        errorPinRetry: 0,
        errorPwdRetry: 0,
      ),
    ];
  }

  Future<List<ApprovalScreenModel>> fetchApprovals({
    String? search,
    int? actionType,
    int? status,
    int page = 1,
    int size = 30,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800)); // Simulasi loading

    return [
      ApprovalScreenModel(
        action: 'Add',
        loginId: 'R1534',
        email: 'evergreenel24@gmail.com',
        loginType: 'Client',
        status: 'Approved',
        accountExpired: 'Never Expired',
        salesBranchId: '-',
        createdBy: 'dimas2',
        permissions: '0',
        approvalId: '10500',
        handphoneNo: '',
        birthDate: '',
      ),
      ApprovalScreenModel(
        action: 'Add',
        loginId: 'H552',
        email: 'argadimasxabre@gmail.com',
        loginType: 'Client',
        status: 'Approved',
        accountExpired: 'Never Expired',
        salesBranchId: '-',
        createdBy: 'dimas2',
        permissions: '0',
        approvalId: '10499',
        handphoneNo: '',
        birthDate: '',
      ),
      ApprovalScreenModel(
        action: 'Add',
        loginId: 'fm958',
        email: 'it@evergreensekuritas.co.id',
        loginType: 'Client',
        status: 'Rejected',
        accountExpired: 'Never Expired',
        salesBranchId: '-',
        createdBy: 'dimas2',
        permissions: '0',
        approvalId: '10497',
        handphoneNo: '',
        birthDate: '',
      ),
      ApprovalScreenModel(
        action: 'Add',
        loginId: 'AL004',
        email: 'aa@aa.aa',
        loginType: 'Branch',
        status: 'Rejected',
        accountExpired: 'Never Expired',
        salesBranchId: 'aa@aa.aa',
        createdBy: 'aa@aa.aa',
        permissions: '0',
        approvalId: '445',
        handphoneNo: '',
        birthDate: '',
      ),
    ];
  }

  // @override
  // Future<List<ResetPasswordReportModel>> fetchResetPasswordReports() async {
  //   await Future.delayed(const Duration(milliseconds: 800));

  //   return [
  //     ResetPasswordReportModel(
  //       no: '1',
  //       clientCode: 'A001',
  //       clientName: 'Budi Santoso',
  //       requestDate: '2026-06-18 10:00',
  //       reason: 'Forgot Password',
  //       validation1: 'Valid',
  //       validation2: 'Matched',
  //       approveBy: 'admin',
  //       approveDate: '2026-06-18 10:15',
  //     ),
  //     ResetPasswordReportModel(
  //       no: '2',
  //       clientCode: 'B005',
  //       clientName: 'Siti Aminah',
  //       requestDate: '2026-06-17 14:30',
  //       reason: 'Locked Account',
  //       validation1: 'Valid',
  //       validation2: 'Matched',
  //       approveBy: 'dimas2',
  //       approveDate: '2026-06-17 15:00',
  //     ),
  //     ResetPasswordReportModel(
  //       no: '3',
  //       clientCode: 'C102',
  //       clientName: 'Andi Wijaya',
  //       requestDate: '2026-06-16 09:20',
  //       reason: 'Forgot PIN',
  //       validation1: 'Pending',
  //       validation2: 'Pending',
  //       approveBy: '-',
  //       approveDate: '-',
  //     ),
  //   ];
  // }

  @override
  Future<void> addCsUser(Map<String, dynamic> requestData) async {
    await Future.delayed(const Duration(milliseconds: 1000));
  }

  @override
  Future<void> deleteCsUser(String loginId) {
    // TODO: implement deleteCsUser
    throw UnimplementedError();
  }

  @override
  Future<void> editCsUser(Map<String, dynamic> requestData) {
    // TODO: implement editCsUser
    throw UnimplementedError();
  }

  @override
  Future<void> resetPassword(Map<String, dynamic> requestData) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> fetchLinkedAccountsDetail(
    String loginId,
    String approvalId,
  ) {
    // <-- Tambahkan parameter kedua di sini
    // TODO: implement fetchLinkedAccountsDetail
    throw UnimplementedError();
  }

  @override
  Future<void> sendEmailForgotPinPassword(
    String loginId,
    int actionType,
    String csLoginId,
  ) {
    return Future.value();
  }

  @override
  Future<List<SendEmailForgotModel>> fetchSendEmailForgotList() async {
    await Future.delayed(
      const Duration(milliseconds: 800),
    ); // Simulasi loading API

    return [
      SendEmailForgotModel(
        actionType: 1,
        loginId: 'Hidayat',
        email: 'dayatburgerkill389@gmail.com',
        loginType: 1,
        status: 1,
      ),
      SendEmailForgotModel(
        actionType: 0,
        loginId: 'A007',
        email: 'dalamsyah09@gmail.com',
        loginType: 1,
        status: 1,
      ),
      SendEmailForgotModel(
        actionType: 1,
        loginId: 'Hidayat',
        email: 'dayatburgerkill389@gmail.com',
        loginType: 1,
        status: 1,
      ),
      SendEmailForgotModel(
        actionType: 0,
        loginId: 'Hidayat',
        email: 'dayatburgerkill389@gmail.com',
        loginType: 1,
        status: 1,
      ),
    ];
  }

  @override
  Future<List<dynamic>> fetchOpeningAccounts({
    int page = 1,
    int size = 10,
    String? custId,
    String? loginId,
  }) {
    // TODO: implement fetchOpeningAccounts
    throw UnimplementedError();
  }

  @override
  Future<List<dynamic>> fetchOpeningAccountSuggestions() async => const [];

  @override
  Future<void> sendEmailOpeningAccount(Map<String, dynamic> payload) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> createSchedulerNotification(Map<String, dynamic> payload) {
    // TODO: implement createSchedulerNotification
    throw UnimplementedError();
  }

  @override
  Future<List<dynamic>> fetchSchedulerNotifications({
    int page = 1,
    int size = 10,
  }) {
    // TODO: implement fetchSchedulerNotifications
    throw UnimplementedError();
  }

  @override
  Future<void> sendPushNotification(Map<String, dynamic> payload) {
    // TODO: implement sendPushNotification
    throw UnimplementedError();
  }

  @override
  Future<String> postAddOnlineUser(Map<String, dynamic> payload) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return "Berhasil memproses data (Mock)";
  }

  @override
  Future<List<AccountLinkModel>> fetchAccountLinks() async => const [];

  @override
  Future<List<AccountLinkModel>> fetchLinkedAccounts(String loginId) async =>
      const [];

  @override
  Future<String> resetOnlinePasswordOrPin(Map<String, dynamic> payload) async {
    return 'Reset Password/PIN berhasil (Mock)';
  }

  @override
  Future<void> updateApprovalStatus(Map<String, dynamic> payload) {
    // TODO: implement updateApprovalStatus
    throw UnimplementedError();
  }
}
