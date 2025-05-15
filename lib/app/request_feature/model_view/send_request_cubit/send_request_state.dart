part of 'send_request_cubit.dart';

abstract class SendRequestState extends Equatable {
  const SendRequestState();

  @override
  List<Object> get props => [];
}

class SendRequestInitial extends SendRequestState {}

class SendRequestLoading extends SendRequestState {}

class SendRequestSuccess extends SendRequestState {}

class SendRequestError extends SendRequestState {}
