import 'package:el_csadmin/core/constants/endpoint.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/features/api_datafeed/data/datasources/api_datafeed_network_data_source.dart';
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
      emit(DashboardError('Datasource dashboard tidak valid.'));
      return;
    }

    final dio = (dataSource as ApiDatafeedNetworkDataSourceImpl).dio;
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

    final errors = <String, String>{};
    if (results[0].error != null) errors['totalCs'] = results[0].error!;
    if (results[1].error != null) errors['totalOnlineId'] = results[1].error!;
    if (results[2].error != null) errors['totalPending'] = results[2].error!;

    emit(
      DashboardLoaded(
        totalCs: results[0].value ?? '—',
        totalUserOnline: results[1].value ?? '—',
        totalPending: results[2].value ?? '—',
        errors: errors,
      ),
    );
  }

  Future<({String? value, String? error})> _fetchTotal(
    Future<dynamic> request,
  ) async {
    try {
      final response = await request;
      final total = _extractTotalItems(response.data);
      if (total == null) {
        return (value: null, error: 'Metadata total_items tidak tersedia.');
      }
      return (value: total, error: null);
    } catch (error) {
      return (value: null, error: error.toString());
    }
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
