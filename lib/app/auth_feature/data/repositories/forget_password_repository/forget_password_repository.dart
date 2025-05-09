part of 'i_forget_password_repository.dart';

class ForgetPasswordRepoImpl implements ForgetPasswordRepository {
  @override
  Future<Either<FailureModel, Map<String, dynamic>>> newPassword(
      {required String email, required String newPassword}) {
    return HttpHelper.handleRequest(
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

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> sendOTP(
      {required String email}) {
    return HttpHelper.handleRequest(
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
  Future<Either<FailureModel, Map<String, dynamic>>> verifyOTP(
      {required String otp}) {
    return HttpHelper.handleRequest(
      (token) => HttpHelper.postData(
        linkUrl: ApiEndpoints.verifyResetCode,
        data: {
          "resetCode": otp,
        },
        token: token,
      ),
    );
  }
}
