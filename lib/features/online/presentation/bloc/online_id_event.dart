import 'package:equatable/equatable.dart';

abstract class OnlineIdEvent extends Equatable {
  const OnlineIdEvent();

  @override
  List<Object> get props => [];
}

class FetchOnlineIdsEvent extends OnlineIdEvent {}