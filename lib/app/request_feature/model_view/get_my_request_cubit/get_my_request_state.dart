import 'package:equatable/equatable.dart';

abstract class GetMyRequestsState extends Equatable {
  const GetMyRequestsState();

  @override
  List<Object> get props => [];
}

class GetMyRequestsInitial extends GetMyRequestsState {}

class GetMyRequestsLoading extends GetMyRequestsState {}

class GetMyRequestsSuccess extends GetMyRequestsState {
  
}

class GetMyRequestsError extends GetMyRequestsState {
  
}
