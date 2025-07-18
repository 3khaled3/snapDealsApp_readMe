import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snap_deals/app/auth_feature/data/models/basic_user_model.dart';
import 'package:snap_deals/app/auth_feature/data/repositories/auth_repository/i_auth_repository.dart';
import 'package:snap_deals/app/notification/data/notification_services.dart';
import 'package:snap_deals/core/constants/constants.dart';
import 'package:snap_deals/core/utils/api_handler.dart';
import 'package:snap_deals/core/utils/hive_helper.dart';

part "profile_state.dart";

class ProfileCubit extends Cubit<ProfileStates> {
  static String? notificationToken;
  static final ProfileCubit _instance = ProfileCubit._();
  static ProfileCubit get instance => _instance;
  ProfileCubit._() : super(ProfileInitial(nonRegisteredUser));

  // <------ User ------> //
  // register
  registerUser({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    emit(ProfileLoading(state.profile));
    // make request
    Either<FailureModel, Map<String, dynamic>> result = await AuthRepositoryImpl
        .instance
        .signup(name: name, email: email, password: password, phone: phone);

    result.fold(
      (left) {
        emit(ProfileError(nonRegisteredUser));
      },
      (right) async {
        setCurrentUser(
            email: email, password: password, customToken: right['token']);

        print('✔️✔️✔️$right}');

        emit(ProfileSuccess(UserModel.fromJson(right["data"])));
        await NotificationService.instance.getDeviceToken();
      },
    );
  }

  // login
  loginUser({
    required String email,
    required String password,
  }) async {
    emit(ProfileLoading(state.profile));

    // make request
    Either<FailureModel, Map<String, dynamic>> result = await AuthRepositoryImpl
        .instance
        .login(email: email, password: password);
    result.fold(
      (left) {
        print('🚨🚨🚨🚨: Profile failed to login');
        emit(ProfileError(nonRegisteredUser));
      },
      (right) async {
        print('✔️✔️✔️${right}}');
        setCurrentUser(
            email: email, password: password, customToken: right['token']);

        print('✔️✔️✔️$right}');

        emit(ProfileSuccess(UserModel.fromJson(right["data"])));
        await NotificationService.instance.getDeviceToken();
      },
    );
  }

  Future<void> updateUser(UserModel userModel, XFile? newProfileImage) async {
    emit(ProfileLoading(state.profile));
    final result = await AuthRepositoryImpl.instance
        .updateUserData(user: userModel, image: newProfileImage);

    result.fold(
      (left) {
        emit(ProfileError(state.profile));
      },
      (right) {
        final email = HiveHelper.instance.getItem("email");
        final password = HiveHelper.instance.getItem("password");

        if (email != null && password != null) {
          ProfileCubit.instance.loginUser(email: email, password: password);
        }
      },
    );
  }

  changePassword({required String newPassword}) async {
    emit(ProfileLoading(state.profile));

    final result = await AuthRepositoryImpl.instance
        .updateUserPassword(newPassword: newPassword);
    result.fold(
      (left) {
        emit(ProfileError(state.profile));
      },
      (right) {
        emit(ProfileSuccess(state.profile));
      },
    );
  }

  //deleteMe
  deleteUser({required String password}) async {
    emit(DeleteUserLoading(state.profile));

    final result =
        await AuthRepositoryImpl.instance.deleteUser(password: password);
    result.fold(
      (left) {
        emit(DeleteUserError(state.profile));
      },
      (right) {
        emit(DeleteUserSuccess(state.profile));
      },
    );
  }

  // logout
  logoutUser() async {
    emit(ProfileLoading(state.profile));
    await resetCurrentUser();
    emit(ProfileInitial(nonRegisteredUser));
  }

  Future<bool?> refreshAccount() async {
    // make request
    Either<FailureModel, Map<String, dynamic>> result =
        await AuthRepositoryImpl.instance.getUserData();

    result.fold(
      (left) {
        emit(ProfileError(nonRegisteredUser));
      },
      (right) {
        final user = UserModel.fromJson(right);

        emit(ProfileSuccess(user));
      },
    );
    return null;
  }

  //
}

setCurrentUser({
  required String email,
  required String password,
  required String customToken,
}) {
  HiveHelper.instance.addItem("email", email);
  HiveHelper.instance.addItem("password", password);
  HiveHelper.instance.addItem('customToken', customToken);
}

resetCurrentUser() async {
  await HiveHelper.instance.removeItem("email");
  await HiveHelper.instance.removeItem("password");
  await HiveHelper.instance.removeItem('customToken');
  Hive.box(Constants.favorites).clear();
}
