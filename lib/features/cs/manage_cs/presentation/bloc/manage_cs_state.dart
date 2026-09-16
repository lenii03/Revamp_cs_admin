import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/manage_cs_user.dart';

part 'manage_cs_state.freezed.dart';

enum ManageCsStatus { initial, loading, success, failure }

@freezed
abstract class ManageCsState with _$ManageCsState {
  const factory ManageCsState({
    @Default(ManageCsStatus.initial) ManageCsStatus status,
    @Default(<ManageCsUser>[]) List<ManageCsUser> allUsers,
    @Default(<ManageCsUser>[]) List<ManageCsUser> csUsers,
    @Default('') String query,
    @Default(1) int page,
    @Default(30) int pageSize,
    @Default('') String errorMessage,
  }) = _ManageCsState;

  const ManageCsState._();

  bool get isLoading => status == ManageCsStatus.loading;
  bool get hasError => status == ManageCsStatus.failure;
  bool get canGoPrevious => page > 1;
  bool get canGoNext => true;
}
