import 'package:el_csadmin/core/constants/endpoint.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/features/api_datafeed/data/datasources/api_datafeed_network_data_source.dart';
import '../../data/models/incomplete_credential_item.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final ApiDatafeedNetworkDataSource dataSource;

  DashboardBloc({required this.dataSource}) : super(DashboardInitial()) {
    on<FetchDashboardMetricsEvent>(_onFetchMetrics);
  }

  Future<void> _onFetchMetrics(
    FetchDashboardMetricsEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    if (dataSource is! ApiDatafeedNetworkDataSourceImpl) {
      emit(DashboardError('Invalid dashboard data source.'));
      return;
    }

    final dio = (dataSource as ApiDatafeedNetworkDataSourceImpl).dio;
    final incompleteFuture = _fetchIncompleteCredentials(dio);
    final results = await Future.wait([
      _fetchTotal(
        dio.get(Endpoint.getCSList, queryParameters: {'page': 1, 'size': 1}),
      ),
      _fetchTotal(
        dio.get(
          Endpoint.getOnlineUser,
          queryParameters: {'page': 1, 'size': 1},
        ),
      ),
      _fetchTotal(
        dio.get(
          Endpoint.getApprovalList,
          queryParameters: {'page': 1, 'size': 1, 'status': '1'},
        ),
      ),
    ]);
    final incompleteResult = await incompleteFuture;

    final errors = <String, String>{};
    if (results[0].error != null) errors['totalCs'] = results[0].error!;
    if (results[1].error != null) errors['totalOnlineId'] = results[1].error!;
    if (results[2].error != null) errors['totalPending'] = results[2].error!;
    if (incompleteResult.error != null) {
      errors['incompleteCredentials'] = incompleteResult.error!;
    }

    emit(
      DashboardLoaded(
        totalCs: results[0].value ?? '—',
        totalUserOnline: results[1].value ?? '—',
        totalPending: results[2].value ?? '—',
        incompleteCredentials: incompleteResult.value ?? '—',
        incompleteCredentialUsers: incompleteResult.users,
        errors: errors,
      ),
    );
  }

  Future<
    ({
      String? value,
      String? error,
      List<IncompleteCredentialItem> users,
    })
  >
  _fetchIncompleteCredentials(
    Dio dio,
  ) async {
    try {
      const pageSize = 500;
      final firstResponse = await dio.get(
        Endpoint.getOnlineUser,
        queryParameters: const {'page': 1, 'size': pageSize},
      );
      final firstData = _extractDataRows(firstResponse.data);

      if (firstData.isEmpty && _isEmptyCollectionResponse(firstResponse.data)) {
        return (
          value: '0',
          error: null,
          users: const <IncompleteCredentialItem>[],
        );
      }

      final allRows = <Map<String, dynamic>>[...firstData];
      final totalPages = _extractTotalPages(
        firstResponse.data,
        receivedItems: firstData.length,
        requestedSize: pageSize,
      );

      for (var page = 2; page <= totalPages; page++) {
        final response = await dio.get(
          Endpoint.getOnlineUser,
          queryParameters: {'page': page, 'size': pageSize},
        );
        allRows.addAll(_extractDataRows(response.data));
      }

      final users = _buildIncompleteCredentialUsers(allRows);
      return (value: users.length.toString(), error: null, users: users);
    } catch (error) {
      if (error is DioException &&
          _isEmptyCollectionResponse(error.response?.data)) {
        return (
          value: '0',
          error: null,
          users: const <IncompleteCredentialItem>[],
        );
      }
      return (
        value: null,
        error: error.toString(),
        users: const <IncompleteCredentialItem>[],
      );
    }
  }

  List<Map<String, dynamic>> _extractDataRows(dynamic responseData) {
    if (responseData is! Map || responseData['data'] is! List) {
      return const [];
    }
    return (responseData['data'] as List)
        .whereType<Map>()
        .map(
          (row) => row.map(
            (key, value) => MapEntry(key.toString().toLowerCase(), value),
          ),
        )
        .toList();
  }

  int _extractTotalPages(
    dynamic responseData, {
    required int receivedItems,
    required int requestedSize,
  }) {
    if (responseData is! Map) return 1;
    final pagination = responseData['pagination'];
    if (pagination is! Map) return 1;

    final explicitPages = int.tryParse(
      (pagination['total_pages'] ?? pagination['totalPages'])?.toString() ?? '',
    );
    if (explicitPages != null && explicitPages > 0) return explicitPages;

    final totalItems = int.tryParse(
      (pagination['total_items'] ?? pagination['totalItems'])?.toString() ?? '',
    );
    if (totalItems == null || totalItems <= 0) return 1;

    final effectiveSize = receivedItems > 0 && receivedItems < requestedSize
        ? receivedItems
        : requestedSize;
    return (totalItems / effectiveSize).ceil();
  }

  List<IncompleteCredentialItem> _buildIncompleteCredentialUsers(
    List<Map<String, dynamic>> rows,
  ) {
    final users = <IncompleteCredentialItem>[];
    for (final row in rows) {
      final emailMissing = _isMissingValue(row['email']);
      final phone = row['phonenumber'] ?? row['handphoneno'] ?? row['handphone'];
      final phoneMissing = _isMissingValue(phone);
      final birthDateMissing = _isMissingValue(row['birthdate']);
      if (!emailMissing && !phoneMissing && !birthDateMissing) continue;

      users.add(
        IncompleteCredentialItem(
          loginId: _displayValue(row['loginid']),
          email: _displayValue(row['email']),
          phoneNumber: _displayValue(phone),
          birthDate: _displayValue(row['birthdate']),
          missingFields: [
            if (emailMissing) 'Email',
            if (phoneMissing) 'Phone Number',
            if (birthDateMissing) 'Birth Date',
          ],
          loginType: int.tryParse(row['logintype']?.toString() ?? '') ?? 0,
          accountExpired: _displayValue(row['accountexpired']),
          permissions:
              int.tryParse(row['permissions']?.toString() ?? '') ?? 0,
          status: int.tryParse(row['status']?.toString() ?? '') ?? 0,
          salesId: _displayValue(row['salesid']),
        ),
      );
    }
    return List.unmodifiable(users);
  }

  bool _isMissingValue(dynamic value) {
    if (value == null) return true;
    final normalized = value.toString().trim().toLowerCase();
    return normalized.isEmpty || normalized == '-' || normalized == 'null';
  }

  String _displayValue(dynamic value) {
    return _isMissingValue(value) ? '-' : value.toString().trim();
  }

  Future<({String? value, String? error})> _fetchTotal(
    Future<dynamic> request,
  ) async {
    try {
      final response = await request;
      final total = _extractTotalItems(response.data);
      if (total == null) {
        if (_isEmptyCollectionResponse(response.data)) {
          return (value: '0', error: null);
        }
        return (value: null, error: 'total_items metadata is unavailable.');
      }
      return (value: total, error: null);
    } catch (error) {
      if (error is DioException &&
          _isEmptyCollectionResponse(error.response?.data)) {
        return (value: '0', error: null);
      }

      final errorText = error.toString().toLowerCase();
      if (errorText.contains('no data available') ||
          errorText.contains('data not found')) {
        return (value: '0', error: null);
      }
      return (value: null, error: error.toString());
    }
  }

  bool _isEmptyCollectionResponse(dynamic responseData) {
    if (responseData is! Map) return false;

    final message = responseData['message']?.toString().toLowerCase() ?? '';
    if (message.contains('no data') ||
        message.contains('data not found') ||
        message.contains('empty')) {
      return true;
    }

    final data = responseData['data'];
    return data is List && data.isEmpty;
  }

  String? _extractTotalItems(dynamic responseData) {
    if (responseData is! Map) return null;
    final pagination = responseData['pagination'];
    if (pagination is Map && pagination['total_items'] != null) {
      return pagination['total_items'].toString();
    }
    if (responseData['total_items'] != null) {
      return responseData['total_items'].toString();
    }
    if (responseData['total'] != null) {
      return responseData['total'].toString();
    }
    return null;
  }
}
