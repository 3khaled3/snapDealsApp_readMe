import 'package:equatable/equatable.dart';

abstract class GetRequestsByIdState extends Equatable {
  const GetRequestsByIdState();

  @override
  List<Object> get props => [];
}

class GetRequestsByIdInitial extends GetRequestsByIdState {}

class GetRequestsByIdLoading extends GetRequestsByIdState {}

class GetRequestsByIdSuccess extends GetRequestsByIdState {}

class GetRequestsByIdError extends GetRequestsByIdState {}
