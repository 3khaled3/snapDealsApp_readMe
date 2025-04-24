part of 'i_auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  // Private constructor to prevent instantiation from outside the class
  AuthRepositoryImpl._();

  // Static variable to hold the instance of the class
  static final AuthRepositoryImpl _instance = AuthRepositoryImpl._();

  // Static getter to access the singleton instance
  static AuthRepositoryImpl get instance => _instance;

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    return await HttpHelper.handleRequest(
      (token) => HttpHelper.postData(
        linkUrl: ApiEndpoints.signup,
        data: {
          "name": name,
          "email": email,
          "password": password,
          "passwordConfirm": password
        },
        token: token,
      ),
    );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> login({
    required String email,
    required String password,
  }) async {
    return await HttpHelper.handleRequest(
      (token) => HttpHelper.postData(
        linkUrl: ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
        token: token,
      ),
    );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> forgotPassword({
    required String email,
  }) async {
    return await HttpHelper.handleRequest(
      (token) => HttpHelper.postData(
        linkUrl: ApiEndpoints.forgotPassword,
        data: {
          "email": email,
        },
        token: token,
      ),
    );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> verifyResetCode({
    required String code,
  }) async {
    return await HttpHelper.handleRequest(
      (token) => HttpHelper.postData(
        linkUrl: ApiEndpoints.verifyResetCode,
        data: {
          "resetCode": code,
        },
        token: token,
      ),
    );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    return await HttpHelper.handleRequest(
      (token) => HttpHelper.putData(
        linkUrl: ApiEndpoints.resetPassword,
        data: {
          "email": email,
          "newPassword": newPassword,
        },
        token: token,
      ),
    );
  }

  // Implementing method to get logged-in user data
  @override
  Future<Either<FailureModel, Map<String, dynamic>>> getUserData() async {
    return await HttpHelper.handleRequest(
      (authToken) => HttpHelper.getData(
        linkUrl: ApiEndpoints.getMe,
        token: authToken,
      ),
    );
  }

  // Implementing method to update user password
  @override
  Future<Either<FailureModel, Map<String, dynamic>>> updateUserPassword(
      {required String newPassword}) async {
    return await HttpHelper.handleRequest(
      (authToken) => HttpHelper.putData(
        linkUrl: ApiEndpoints.changeMyPassword,
        data: {'password': newPassword},
        token: authToken,
      ),
    );
  }

  // Implementing method to update logged-in user data (email, phone, etc.)
  @override
  Future<Either<FailureModel, Map<String, dynamic>>> updateUserData(
      {required Map<String, dynamic> data}) async {
    return await HttpHelper.handleRequest(
      (authToken) => HttpHelper.putData(
        linkUrl: ApiEndpoints.updateMe,
        data: data,
        token: authToken,
      ),
    );
  }

  // Implementing method to delete logged-in user
  @override
  Future<Either<FailureModel, Map<String, dynamic>>> deleteUser(
      {required String password}) async {
    return await HttpHelper.handleRequest(
      (authToken) => HttpHelper.deleteData(
        linkUrl: ApiEndpoints.deleteMe,
        data: {'password': password},
        token: authToken,
      ),
    );
  }
}
