import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/incomplete_credential.dart';

part 'dashboard_state.freezed.dart';

@freezed
abstract class DashboardState with _$DashboardState {
  const factory DashboardState.initial() = DashboardInitial;

  const factory DashboardState.loading() = DashboardLoading;

  const factory DashboardState.loaded({
    required String totalCs,
    required String totalUserOnline,
    required String totalPending,
    required String incompleteCredentials,
    required List<IncompleteCredential> incompleteCredentialUsers,
    @Default(<String, String>{}) Map<String, String> errors,
  }) = DashboardLoaded;

  const factory DashboardState.error(String message) = DashboardError;
}
