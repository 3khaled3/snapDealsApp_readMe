import 'dart:io';

import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:snap_deals/app/auth_feature/data/models/basic_user_model.dart';
import 'package:snap_deals/core/utils/api_endpoints.dart';
import 'package:snap_deals/core/utils/api_handler.dart';
import 'package:dartz/dartz.dart';
part 'auth_repository.dart';

abstract class AuthRepository {
  Future<Either<FailureModel, Map<String, dynamic>>> signup({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<FailureModel, Map<String, dynamic>>> login({
    required String email,
    required String password,
  });
  Future<Either<FailureModel, Map<String, dynamic>>> forgotPassword({
    required String email,
  });
  Future<Either<FailureModel, Map<String, dynamic>>> verifyResetCode({
    required String code,
  });
  Future<Either<FailureModel, Map<String, dynamic>>> resetPassword({
    required String email,
    required String newPassword,
  });
  // Method to get logged-in user data
  Future<Either<FailureModel, Map<String, dynamic>>> getUserData();
  Future<Either<FailureModel, Map<String, dynamic>>> getSpecificUserData(
      String id);

  // Method to update user password
  Future<Either<FailureModel, Map<String, dynamic>>> updateUserPassword({
    required String newPassword,
  });

  // Method to update logged-in user data (email, phone, etc.)
  Future<Either<FailureModel, Map<String, dynamic>>> updateUserData({
    required UserModel user,
    XFile? image,
  });

  // Method to delete logged-in user
  Future<Either<FailureModel, Map<String, dynamic>>> deleteUser({
    required String password,
  });
}
