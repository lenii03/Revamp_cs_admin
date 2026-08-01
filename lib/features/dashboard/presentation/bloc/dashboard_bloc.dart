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

    try {
      if (dataSource is ApiDatafeedNetworkDataSourceImpl) {
        final dio = (dataSource as ApiDatafeedNetworkDataSourceImpl).dio;
        Future<String> fetchTotalSafe(
          String url,
          Map<String, dynamic> params,
        ) async {
          try {
            final res = await dio.get(url, queryParameters: params);
            return _extractTotalItems(res.data);
          } catch (e) {
            print("⚠️ API GAGAL PADA ENDPOINT ($url): $e");
            return "0"; 
          }
        }
        final results = await Future.wait([
          fetchTotalSafe(Endpoint.getCSList, {'page': 1, 'size': 1}),
          fetchTotalSafe(Endpoint.getOnlineUser, {'page': 1, 'size': 1}),
          fetchTotalSafe(Endpoint.getApprovalList, {'page': 1, 'size': 1}),
        ]);

        emit(
          DashboardLoaded(
            totalCs: results[0],
            totalUserOnline: results[1],
            totalPending: results[2],
          ),
        );
      } else {
        emit(
          DashboardLoaded(
            totalCs: "0",
            totalUserOnline: "0",
            totalPending: "0",
          ),
        );
      }
    } catch (e) {
      print("❌ FATAL ERROR DASHBOARD BLOC: $e");
      emit(DashboardError('Gagal memuat statistik dashboard'));
    }
  }

  String _extractTotalItems(dynamic responseData) {
    try {
      if (responseData is Map<String, dynamic>) {
        if (responseData['pagination'] != null &&
            responseData['pagination']['total_items'] != null) {
          return responseData['pagination']['total_items'].toString();
        }
        if (responseData['total_items'] != null)
          return responseData['total_items'].toString();
        if (responseData['total'] != null)
          return responseData['total'].toString();
      }
    } catch (_) {}
    return '0';
  }
}
