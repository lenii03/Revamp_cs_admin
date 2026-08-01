import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:el_csadmin/features/online/online_id/data/models/online_id_model.dart';

part 'online_id_event.freezed.dart';

@freezed
class OnlineIdEvent with _$OnlineIdEvent {
  const factory OnlineIdEvent.fetchOnlineIds() = _FetchOnlineIds;

  const factory OnlineIdEvent.addOnlineId(Map<String, dynamic> data) =
      _AddOnlineId;

  const factory OnlineIdEvent.editOnlineId(Map<String, dynamic> data) =
      _EditOnlineId;

  const factory OnlineIdEvent.deleteOnlineId(String loginId) = _DeleteOnlineId;

  const factory OnlineIdEvent.resetOnlineId({
    required String loginId,
    required String resetType,
  }) = _ResetOnlineId;

  const factory OnlineIdEvent.selectOnlineId(OnlineIdModel selectedUser) =
      _SelectOnlineId;
  const factory OnlineIdEvent.searchOnlineIds(String query) = _SearchOnlineIds;
}
