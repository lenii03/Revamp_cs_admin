import 'package:flutter/foundation.dart'; // Tambahkan ini untuk debugPrint
import 'package:flutter_bloc/flutter_bloc.dart';
import 'approve_opening_event.dart';
import 'approve_opening_state.dart';
import '../../../../../shared/features/api_datafeed/domain/repositories/api_datafeed_repository.dart';
import '../../data/models/approve_opening_account_model.dart';

class ApproveOpeningBloc
    extends Bloc<ApproveOpeningEvent, ApproveOpeningState> {
  final ApiDatafeedRepository repository;

  // Keranjang tabel utama
  final List<ApproveOpeningAccountModel> _stagedAccounts = [];

  // 👇 1. Tambahkan penampung data API agar bisa dipanggil instan tanpa loading
  List<ApproveOpeningAccountModel> apiAccountsList = [];

  ApproveOpeningBloc({required this.repository})
    : super(const ApproveOpeningLoaded([])) {
    // 👇 2. Panggil API secara diam-diam saat halaman pertama kali dibuka
    _loadApiDataInBackground();

    on<AddToStaging>((event, emit) {
      if (!_stagedAccounts.any((acc) => acc.loginId == event.account.loginId)) {
        _stagedAccounts.add(event.account);
      }
      emit(ApproveOpeningLoaded(List.from(_stagedAccounts)));
    });

    on<RemoveFromStaging>((event, emit) {
      _stagedAccounts.removeWhere(
        (acc) => acc.loginId == event.account.loginId,
      );
      emit(ApproveOpeningLoaded(List.from(_stagedAccounts)));
    });

    on<ClearStaging>((event, emit) {
      _stagedAccounts.clear();
      emit(const ApproveOpeningLoaded([]));
    });

    on<SendEmailOpeningAccount>((event, emit) async {
      // Implementasi aksi Send Email
    });
  }

  // 👇 Fungsi untuk pre-fetch data
  Future<void> _loadApiDataInBackground() async {
    final result = await repository.fetchOpeningAccounts();
    result.fold(
      (error) => debugPrint("Gagal pre-fetch data: $error"),
      (data) => apiAccountsList = data,
    );
  }
}
