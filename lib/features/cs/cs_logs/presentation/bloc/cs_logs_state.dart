import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/cs_log.dart';

part 'cs_logs_state.freezed.dart';

enum CsLogsStatus { initial, loading, success, failure }

@freezed
abstract class CsLogsState with _$CsLogsState {
  const factory CsLogsState({
    @Default(CsLogsStatus.initial) CsLogsStatus status,
    @Default(<CsLog>[]) List<CsLog> logs,
    @Default('') String loginId,
    @Default('') String targetId,
    @Default(-1) int logType,
    @Default(1) int page,
    @Default(30) int pageSize,
    @Default('') String errorMessage,
  }) = _CsLogsState;

  const CsLogsState._();

  bool get isLoading => status == CsLogsStatus.loading;
  bool get hasError => status == CsLogsStatus.failure;
  bool get canGoPrevious => page > 1;
  // Kept enabled to match the previous pagination control behaviour.
  bool get canGoNext => true;
}
