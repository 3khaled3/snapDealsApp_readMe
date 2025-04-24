import 'package:snap_deals/core/utils/api_endpoints.dart';
import 'package:snap_deals/core/utils/api_handler.dart';
import 'package:dartz/dartz.dart';
part "forget_password_repository.dart";

abstract class ForgetPasswordRepository {
  Future<Either<FailureModel, Map<String, dynamic>>> newPassword({
    required String email,
    required String newPassword,
  });
  Future<Either<FailureModel, Map<String, dynamic>>> verifyOTP({
    required String otp,
  });
  Future<Either<FailureModel, Map<String, dynamic>>> sendOTP({
    required String email,
  });
}
