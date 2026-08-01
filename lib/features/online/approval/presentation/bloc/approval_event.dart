import 'package:el_csadmin/features/online/approval/data/models/approval_screen_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'approval_event.freezed.dart';

@freezed
class ApprovalScreenEvent with _$ApprovalScreenEvent {
  const factory ApprovalScreenEvent.fetchApprovals() = _FetchApprovals;
  const factory ApprovalScreenEvent.approveItem(ApprovalScreenModel data) =
      _ApproveItem;
  const factory ApprovalScreenEvent.rejectItem(ApprovalScreenModel data) =
      _RejectItem;
}
