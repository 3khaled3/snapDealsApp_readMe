import 'package:equatable/equatable.dart';
import 'package:snap_deals/app/request_feature/data/model/instractor/instractor.request.model.dart';

abstract class GetRequestsByIdState extends Equatable {
  const GetRequestsByIdState();

  @override
  List<Object> get props => [];
}

class GetRequestsByIdInitial extends GetRequestsByIdState {}

class GetRequestsByIdLoading extends GetRequestsByIdState {}

class GetRequestsByIdSuccess extends GetRequestsByIdState {
  final List<InstractorRequestModel> requests;

  const GetRequestsByIdSuccess(this.requests);
}

class GetRequestsByIdError extends GetRequestsByIdState {}
