import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/approval_screen_model.dart';

part 'approval_state.freezed.dart';

@freezed
class ApprovalScreenState with _$ApprovalScreenState {
  const factory ApprovalScreenState.initial() = _Initial;

  const factory ApprovalScreenState.loading() = _Loading;

  const factory ApprovalScreenState.loaded(List<ApprovalScreenModel> data) =
      _Loaded;

  const factory ApprovalScreenState.error(String message) = _Error;
}
