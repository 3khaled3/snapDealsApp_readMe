import 'package:dartz/dartz.dart';
import 'package:snap_deals/core/utils/api_endpoints.dart';
import 'package:snap_deals/core/utils/api_handler.dart';

part 'request_repository.dart';

abstract class IRequestRepository {
  Future<Either<FailureModel, Map<String, dynamic>>> sendRequest(
      String courseId);
  Future<Either<FailureModel, Map<String, dynamic>>> getRequestsById(
      String courseId);
  Future<Either<FailureModel, Map<String, dynamic>>> approveRequest(
      String requestId);
  Future<Either<FailureModel, Map<String, dynamic>>> rejectRequest(
      String requestId);
  Future<Either<FailureModel, Map<String, dynamic>>> cancelRequest(
      String requestId);
  Future<Either<FailureModel, Map<String, dynamic>>> getMyRequest();
}
