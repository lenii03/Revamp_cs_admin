// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/constants/endpoint.dart';
import '../../injector.dart';
import '../local/session_service.dart';
import '../remote/dio_api_base.dart';
import '../remote/dio_client.dart';

class LoginRepository extends DioApiBase<LoginUserModel> {
  final DioClient _dioClient = locator<DioClient>();
  CancelToken? cancelToken;

  Future<Either<String, LoginUserModel>> login(
    Map<String, dynamic> form,
  ) async {
    cancelToken = CancelToken();
    final dioClient = locator<DioClient>();
    return makeLoginRequestC(
      apiRequest: _dioClient.dio.post(
        Endpoint.signIn,
        data: jsonEncode(form),
        cancelToken: cancelToken,
      ),
      decoder: (rawData) => proccesLogin(rawData),
    );
  }

  Future<Either<String, String>> resetPasswordCS(
    Map<String, dynamic> postData,
  ) async {
    final dioClient = locator<DioClient>();
    return makeSingleRequest(
      apiRequest: _dioClient.dio.post(Endpoint.resetPasswordCs, data: postData),
    );
  }

  Future<Either<String, String>> logOut(Map<String, dynamic> form) async {
    return makeSingleRequest(
      apiRequest: _dioClient.dio.post(Endpoint.signOut, data: jsonEncode(form)),
    );
  }

  //! Java
  // Future<LoginUserModel> decodeBinary(Map<String, dynamic> rawData) async {
  //   Uint8List data = Uint8List(0);
  //   Uint8List resEnd = Uint8List(0);
  //   LoginUserModel result = LoginUserModel();
  //   var token = '';
  //   SessionService sessionService = Get.find();
  //   // sessionService.write(SessionKey.token, token);
  //   // print(token);
  //   int listLength = rawData['List'];
  //   int originalSize = 0;
  //   List<int> bufData = List<int>.from(rawData["BYTE"]);
  //   bool compressed = rawData['COMPRESSED'];
  //   DynamicLibrary dynamicLibrary = Get.find(tag: "dynamicLibrary");
  //   SnappyHelper snappyHelper = SnappyHelper(dynamicLibrary);
  //   data = Uint8List.fromList(data.toList()..addAll(bufData));
  //   if (compressed == true) {
  //     originalSize = rawData["OriSize"];
  //     Uint8List decom = snappyHelper.uncompress(data, originalSize);
  //     resEnd = Uint8List.fromList(resEnd.toList()..addAll(decom));
  //   } else {
  //     resEnd = Uint8List.fromList(resEnd.toList()..addAll(data));
  //   }
  //   var getController = Get.put(EncryptControl());
  //   getController.readPos.value = 0;
  //   for (var i = 0; i < listLength; i++) {
  //     int lLoginId = getController.encrypt2(resEnd);
  //     String loginId = getController.getAsciiString(resEnd, lLoginId);
  //     int lemployeeId = getController.encrypt2(resEnd);
  //     String employeeId = getController.getAsciiString(resEnd, lemployeeId);
  //     int lEmployeeName = getController.encrypt2(resEnd);
  //     String employeeName = getController.getAsciiString(resEnd, lEmployeeName);
  //     int lEmail = getController.encrypt2(resEnd);
  //     String email = getController.getAsciiString(resEnd, lEmail);
  //     int status = getController.encrypt1(resEnd);
  //     int cCsLogin = getController.encrypt1(resEnd);
  //     int cUserLogin = getController.encrypt1(resEnd);
  //     int approveUserLogin = getController.encrypt1(resEnd);
  //     int cDemoLogin = getController.encrypt1(resEnd);
  //     int viewCsLogs = getController.encrypt1(resEnd);
  //     int approvalOpeningaccount = getController.encrypt1(resEnd);
  //     int viewReports = getController.encrypt1(resEnd);
  //     int sendOlUserDisc = getController.encrypt1(resEnd);
  //     int viewCusRatio = getController.encrypt1(resEnd);
  //     int lToken = getController.encrypt2(resEnd);
  //     token = getController.getAsciiString(resEnd, lToken);
  //     sessionService.write(SessionKey.token, token);
  //     sessionService.read(
  //       SessionKey.token,
  //     );
  //     print(token);
  //     result = LoginUserModel(
  //       loginId: loginId,
  //       employeeId: employeeId,
  //       employeeName: employeeName,
  //       email: email,
  //       status: status,
  //       createCsLogin: cCsLogin,
  //       createUserLogin: cUserLogin,
  //       approveUserLogin: approveUserLogin,
  //       createDemoAccount: cDemoLogin,
  //       viewCsLogs: viewCsLogs,
  //       approval_openingAccount: approvalOpeningaccount,
  //       viewReports: viewReports,
  //       sendOlUserDisc: sendOlUserDisc,
  //       viewCusRatio: viewCusRatio,
  //     );
  //     print(result.loginId);
  //     sessionService.write(SessionKey.loginId, result.loginId ?? '');
  //   }
  //   return result;
  // }

  //!C
  Future<LoginUserModel> proccesLogin(Map<String, dynamic> rawData) async {
    try {
      final sessionService = locator<SessionService>();
      final Map<String, dynamic> data = rawData['data'] ?? {};
      final message = rawData['message'] ?? "null Message";
      print("\n🚀 === BUKTI DATA ASLI DARI SERVER ===");
      print(rawData.toString());
      print("=======================================\n");

      print("cs/login M: $message");
      String token = data['Token'];
      sessionService.write(SessionKey.token, token);
      sessionService.read(SessionKey.token);
      if (data.isNotEmpty) {
        final LoginUserModel loginUser = LoginUserModel.fromMap(data);
        return loginUser;
      } else {
        throw Exception("No data available in response");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

class LoginUserModel {
  String loginId;
  String employeeId;
  String email;
  int status;
  int permissions;
  int? createCsLogin;
  int? createUserLogin;
  int? approveUserLogin;
  int? createDemoAccount;
  int? viewCsLogs;
  int? approvalOpeningAccount;
  int? viewReports;
  int? sendOlUserDisc;
  int? viewCusRatio;
  LoginUserModel({
    this.loginId = '',
    this.employeeId = '',
    this.email = '',
    this.status = 0,
    this.permissions = 0,
  }) {
    _parsePermissions();
  }

  // Method to extract permissions from the integer using bitwise operations
  void _parsePermissions() {
    createCsLogin = (permissions & (1 << 0)) != 0 ? 1 : 0;
    createUserLogin = (permissions & (1 << 1)) != 0 ? 1 : 0;
    approveUserLogin = (permissions & (1 << 2)) != 0 ? 1 : 0;
    createDemoAccount = (permissions & (1 << 3)) != 0 ? 1 : 0;
    viewCsLogs = (permissions & (1 << 4)) != 0 ? 1 : 0;
    approvalOpeningAccount = (permissions & (1 << 5)) != 0 ? 1 : 0;
    viewReports = (permissions & (1 << 6)) != 0 ? 1 : 0;
    sendOlUserDisc = (permissions & (1 << 7)) != 0 ? 1 : 0;
    viewCusRatio = (permissions & (1 << 8)) != 0 ? 1 : 0;
  }

  // Method to update the permissions integer based on the individual permission flags
  void _updatePermissions() {
    permissions = 0;
    if (createCsLogin == 1) permissions |= (1 << 0);
    if (createUserLogin == 1) permissions |= (1 << 1);
    if (approveUserLogin == 1) permissions |= (1 << 2);
    if (createDemoAccount == 1) permissions |= (1 << 3);
    if (viewCsLogs == 1) permissions |= (1 << 4);
    if (approvalOpeningAccount == 1) permissions |= (1 << 5);
    if (viewReports == 1) permissions |= (1 << 6);
    if (sendOlUserDisc == 1) permissions |= (1 << 7);
    if (viewCusRatio == 1) permissions |= (1 << 8);
  }

  Map<String, dynamic> toMap() {
    _updatePermissions(); // Update the permissions before converting to map
    return <String, dynamic>{
      'LoginId': loginId,
      'EmployeeId': employeeId,
      'Email': email,
      'Status': status,
      'Permissions': permissions,
    };
  }

  factory LoginUserModel.fromMap(Map<String, dynamic> map) {
    LoginUserModel user = LoginUserModel(
      loginId: map['LoginId'],
      employeeId: map['EmployeeId'],
      email: map['Email'],
      status: map['Status'],
      permissions: map['Permissions'],
    );
    user._parsePermissions(); // Parse the permissions after loading from map
    return user;
  }

  String toJson() => json.encode(toMap());

  factory LoginUserModel.fromJson(String source) =>
      LoginUserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
