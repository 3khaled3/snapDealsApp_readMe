part of 'approve_request_cubit.dart';

abstract class ApproveRequestState extends Equatable {
  const ApproveRequestState();

  @override
  List<Object> get props => [];
}

class ApproveRequestInitial extends ApproveRequestState {}

class ApproveRequestLoading extends ApproveRequestState {}

class ApproveRequestSuccess extends ApproveRequestState {}

class ApproveRequestError extends ApproveRequestState {}
