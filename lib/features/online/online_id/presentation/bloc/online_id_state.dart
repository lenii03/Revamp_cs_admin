import 'package:equatable/equatable.dart';
import '../../data/models/online_id_model.dart';

abstract class OnlineIdState extends Equatable {
  const OnlineIdState();
  
  @override
  List<Object> get props => [];
}

class OnlineIdInitial extends OnlineIdState {}

class OnlineIdLoading extends OnlineIdState {}

class OnlineIdLoaded extends OnlineIdState {
  final List<OnlineIdModel> data;

  const OnlineIdLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class OnlineIdError extends OnlineIdState {
  final String message;

  const OnlineIdError(this.message);

  @override
  List<Object> get props => [message];
}