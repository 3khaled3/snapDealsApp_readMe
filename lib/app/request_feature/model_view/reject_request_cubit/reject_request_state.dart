part of 'reject_request_cubit.dart';

abstract class RejectRequestState extends Equatable {
  const RejectRequestState();

  @override
  List<Object> get props => [];
}

class RejectRequestInitial extends RejectRequestState {}

class RejectRequestLoading extends RejectRequestState {}

class RejectRequestSuccess extends RejectRequestState {}

class RejectRequestError extends RejectRequestState {}
