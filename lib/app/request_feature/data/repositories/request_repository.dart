part of "i_request_repository.dart";

class RequestRepository implements IRequestRepository {
  @override
  Future<Either<FailureModel, Map<String, dynamic>>> approveRequest(
      String requestId) {
    return HttpHelper.handleRequest(
      (token) => HttpHelper.postData(
        linkUrl: ApiEndpoints.approveRequest(requestId),
        data: {},
        token: token,
      ),
    );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> cancelRequest(
      String requestId) {
    return HttpHelper.handleRequest(
      (token) => HttpHelper.deleteData(
        linkUrl: ApiEndpoints.cancelRequest(requestId),
        token: token,
      ),
    );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> getMyRequest() {
    return HttpHelper.handleRequest(
      (token) => HttpHelper.getData(
        linkUrl: ApiEndpoints.myRequests,
        token: token,
      ),
    );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> getRequestsById(
      String courseId) {
    return HttpHelper.handleRequest(
      (token) => HttpHelper.getData(
        linkUrl: ApiEndpoints.requestById(courseId),
        token: token,
      ),
    );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> rejectRequest(
      String requestId) {
    return HttpHelper.handleRequest(
      (token) => HttpHelper.postData(
        linkUrl: ApiEndpoints.rejectRequest(requestId),
        data: {},
        token: token,
      ),
    );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> sendRequest(
      String courseId) {
    return HttpHelper.handleRequest(
      (token) => HttpHelper.postData(
        linkUrl: ApiEndpoints.requestById(courseId),
        data: {},
        token: token,
      ),
    );
  }
}
