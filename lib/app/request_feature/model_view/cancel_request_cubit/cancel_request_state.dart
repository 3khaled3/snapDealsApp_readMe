part of 'cancel_request_cubit.dart';

abstract class CancelRequestState extends Equatable {
  const CancelRequestState();

  @override
  List<Object> get props => [];
}

class CancelRequestInitial extends CancelRequestState {}

class CancelRequestLoading extends CancelRequestState {}

class CancelRequestSuccess extends CancelRequestState {}

class CancelRequestError extends CancelRequestState {}
