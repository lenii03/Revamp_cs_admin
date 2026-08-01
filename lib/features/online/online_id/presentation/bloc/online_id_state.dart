import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:el_csadmin/features/online/online_id/data/models/online_id_model.dart';

part 'online_id_state.freezed.dart';

@freezed
class OnlineIdState with _$OnlineIdState {
  const factory OnlineIdState.initial() = _Initial;
  
  const factory OnlineIdState.loading() = _Loading;
  
  const factory OnlineIdState.loaded({
    required List<OnlineIdModel> data,
    OnlineIdModel? selectedUser,
  }) = _Loaded;
  
  const factory OnlineIdState.error(String message) = _Error;
}