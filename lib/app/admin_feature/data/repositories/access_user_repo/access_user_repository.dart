part of 'i_access_user_repository.dart';

class AccessUserRepositoryImpl implements AccessUserRepository {
  @override
  Future<Either<FailureModel, Map<String, dynamic>>> getAllUsersData(
      {required String limit, required String page}) async {
    return await HttpHelper.handleRequest(
      (token) => HttpHelper.getData(
        linkUrl: "${ApiEndpoints.users}?page=$page&limit=$limit",
        token: token,
      ),
    );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> deleteUser(
      {required String userId}) async {
    return await HttpHelper.handleRequest(
      (token) => HttpHelper.deleteData(
        linkUrl: ApiEndpoints.userById(userId),
        token: token,
      ),
    );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> getUserDataById(
      {required String userId}) async {
    return await HttpHelper.handleRequest(
      (token) => HttpHelper.getData(
        linkUrl: ApiEndpoints.userById(userId),
        token: token,
      ),
    );
  }
}
