import 'package:el_csadmin/core/constants/endpoint.dart';
import 'package:el_csadmin/data/remote/dio_client.dart';

abstract class ApproveOpeningRemoteDataSource {
  Future<List<dynamic>> fetchAccounts({
    int page = 1,
    int size = 10,
    String? custId,
    String? loginId,
  });
  Future<List<dynamic>> fetchSuggestions();
  Future<void> sendEmail(Map<String, dynamic> payload);
}

class ApproveOpeningRemoteDataSourceImpl
    implements ApproveOpeningRemoteDataSource {
  const ApproveOpeningRemoteDataSourceImpl(this._client);
  final DioClient _client;

  @override
  Future<List<dynamic>> fetchAccounts({
    int page = 1,
    int size = 10,
    String? custId,
    String? loginId,
  }) async {
    final response = await _client.get(
      Endpoint.getListOpeningAccount,
      queryParameters: {
        'page': page,
        'size': size,
        if (custId != null && custId.isNotEmpty) 'custId': custId,
        if (loginId != null && loginId.isNotEmpty) 'loginId': loginId,
      },
    );
    if (response.statusCode != 200) {
      throw Exception(
        response.data['message'] ?? 'Failed to load Opening Account data',
      );
    }
    return response.data['data'] as List<dynamic>;
  }

  @override
  Future<List<dynamic>> fetchSuggestions() async {
    final response = await _client.get(
      Endpoint.getListOpeningAccountSuggestion,
      queryParameters: const {'custId': '', 'loginId': ''},
    );
    return (response.data['data'] as List<dynamic>?) ?? const [];
  }

  @override
  Future<void> sendEmail(Map<String, dynamic> payload) async {
    final response = await _client.post(
      Endpoint.sendEmailOpeningAccountWithRekening,
      data: payload,
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      final data = response.data;
      throw Exception(
        data is Map
            ? data['message'] ?? 'Failed to send email'
            : 'Failed to send email',
      );
    }
  }
}
