import 'package:dio/dio.dart';
import 'package:el_csadmin/features/cs/cs_logs/data/models/cs_log_model.dart';
import 'package:el_csadmin/features/online/online_id/data/models/online_id_model.dart';
import '../../../../../core/constants/endpoint.dart';
import '../../../../../core/network/server_config.dart';
import '../../../../../features/online/approval/data/models/approval_screen_model.dart';
import '../../../../../features/cs/manage_cs/data/models/cs_user_model.dart';
import '../../../../../features/reports/reset_password_report/data/models/reset_password_report_model.dart';

abstract class ApiDatafeedNetworkDataSource {
  Future<List<ManageCsUsersModel>> fetchCsList();
  Future<List<CsLogModel>> fetchCsLogs({String? loginId, String? targetId});
  Future<List<OnlineIdModel>> fetchOnlineIds();
  Future<List<ApprovalScreenModel>> fetchApprovals();
  Future<List<ResetPasswordReportModel>> fetchResetPasswordReports();
  Future<void> addCsUser(Map<String, dynamic> requestData);
  Future<void> deleteCsUser(String loginId);
  Future<void> editCsUser(Map<String, dynamic> requestData);
  Future<void> resetPassword(Map<String, dynamic> requestData);
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
  }) async {
    final baseUrl = await ServerConfig.getBaseUrl();
    if (baseUrl.isEmpty) throw Exception('IP Server belum dikonfigurasi.');
    dio.options.baseUrl = baseUrl;

    final response = await dio.get(
      Endpoint.getCsLogs,
      queryParameters: {
        "page": 1,
        "size": 30,
        "login_id": loginId,
        "target_id": targetId,
      },
    );

    final List<dynamic> responseData = response.data['data'] ?? [];
    return responseData
        .map((item) => CsLogModel.fromMap(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<OnlineIdModel>> fetchOnlineIds() async {
    throw UnimplementedError('API Real untuk Online IDs belum dibuat');
  }

  @override
  Future<List<ApprovalScreenModel>> fetchApprovals() async {
    throw UnimplementedError('API Real untuk Approval belum dibuat');
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
  Future<List<OnlineIdModel>> fetchOnlineIds() async {
    await Future.delayed(const Duration(milliseconds: 800));

    return [
      OnlineIdModel(
        loginId: 'a003',
        email: 'dimas@evergreensekuritas.co.id',
        approvedAt: '2026-02-25 09:31:21',
        hp: '081578375557',
        birth: '2001-01-01',
        type: 'Client',
        status: 'Active',
        pwdRetry: '0',
        pinRetry: '0',
      ),
      OnlineIdModel(
        loginId: 'A009',
        email: 'm@m.mm',
        approvedAt: '-',
        hp: '-',
        birth: '-',
        type: 'Client',
        status: 'Active',
        pwdRetry: '0',
        pinRetry: '0',
      ),
      OnlineIdModel(
        loginId: 'alam',
        email: 'dalamsyah09@gmail.com',
        approvedAt: '-',
        hp: '-',
        birth: '-',
        type: 'Client',
        status: 'Active',
        pwdRetry: '10',
        pinRetry: '0',
      ),
      OnlineIdModel(
        loginId: 'andri2',
        email: 'andri2@gmail.com',
        approvedAt: '-',
        hp: '-',
        birth: '-',
        type: 'Sales',
        status: 'Active',
        pwdRetry: '0',
        pinRetry: '0',
      ),
    ];
  }

  Future<List<ApprovalScreenModel>> fetchApprovals() async {
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
      ),
    ];
  }

  @override
  Future<List<ResetPasswordReportModel>> fetchResetPasswordReports() async {
    await Future.delayed(const Duration(milliseconds: 800));

    return [
      ResetPasswordReportModel(
        no: '1',
        clientCode: 'A001',
        clientName: 'Budi Santoso',
        requestDate: '2026-06-18 10:00',
        reason: 'Forgot Password',
        validation1: 'Valid',
        validation2: 'Matched',
        approveBy: 'admin',
        approveDate: '2026-06-18 10:15',
      ),
      ResetPasswordReportModel(
        no: '2',
        clientCode: 'B005',
        clientName: 'Siti Aminah',
        requestDate: '2026-06-17 14:30',
        reason: 'Locked Account',
        validation1: 'Valid',
        validation2: 'Matched',
        approveBy: 'dimas2',
        approveDate: '2026-06-17 15:00',
      ),
      ResetPasswordReportModel(
        no: '3',
        clientCode: 'C102',
        clientName: 'Andi Wijaya',
        requestDate: '2026-06-16 09:20',
        reason: 'Forgot PIN',
        validation1: 'Pending',
        validation2: 'Pending',
        approveBy: '-',
        approveDate: '-',
      ),
    ];
  }

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
}
