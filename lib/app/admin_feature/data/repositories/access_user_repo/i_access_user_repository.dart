import 'package:dartz/dartz.dart';
import 'package:snap_deals/core/utils/api_endpoints.dart';
import 'package:snap_deals/core/utils/api_handler.dart';
part 'access_user_repository.dart';
abstract class AccessUserRepository {
  Future<Either<FailureModel, Map<String, dynamic>>> getAllUsersData({required String limit, required String page});

  Future<Either<FailureModel, Map<String, dynamic>>> getUserDataById({
    required String userId,
  });
  Future<Either<FailureModel, Map<String, dynamic>>> deleteUser({
    required String userId,
  });
}
