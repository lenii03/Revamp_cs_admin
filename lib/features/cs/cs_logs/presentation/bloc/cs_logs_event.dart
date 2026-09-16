import 'package:freezed_annotation/freezed_annotation.dart';

part 'cs_logs_event.freezed.dart';

@freezed
abstract class CsLogsEvent with _$CsLogsEvent {
  const factory CsLogsEvent.fetchCsLogs({
    String? loginId,
    String? targetId,
    int? logType,
    @Default(1) int page,
    @Default(30) int pageSize,
  }) = FetchCsLogsEvent;

  const factory CsLogsEvent.changeCsLogsPage(int page) = ChangeCsLogsPage;

  const factory CsLogsEvent.changeCsLogsPageSize(int pageSize) =
      ChangeCsLogsPageSize;
}
