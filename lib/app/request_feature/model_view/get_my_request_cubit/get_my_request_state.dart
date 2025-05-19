import 'package:equatable/equatable.dart';
import 'package:snap_deals/app/request_feature/data/model/request/request.dart';

abstract class GetMyRequestsState extends Equatable {
  const GetMyRequestsState();

  @override
  List<Object> get props => [];
}

class GetMyRequestsInitial extends GetMyRequestsState {}

class GetMyRequestsLoading extends GetMyRequestsState {}

class GetMyRequestsSuccess extends GetMyRequestsState {
  final List<RequestModel> requests;
  const GetMyRequestsSuccess({required this.requests});
}

class GetMyRequestsError extends GetMyRequestsState {}
