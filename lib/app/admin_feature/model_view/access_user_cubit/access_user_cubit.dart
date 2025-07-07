import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:snap_deals/app/admin_feature/data/repositories/access_user_repo/i_access_user_repository.dart';
import 'package:snap_deals/app/auth_feature/data/models/basic_user_model.dart';

part 'access_user_state.dart';

class AccessUserCubit extends Cubit<AccessUserState> {
  AccessUserCubit() : super(AccessUserInitial());
  final _accessUserRepository = AccessUserRepositoryImpl();

  Future<void> getAllUsersData(
      {required String limit, required String page}) async {
    debugPrint('Fetching users with limit: $limit, page: $page');
    emit(GetAllUsersLoading());
    final result =
        await _accessUserRepository.getAllUsersData(limit: limit, page: page);
    result.fold((l) => emit(GetAllUsersError()), (r) {
      final List usersMap = r["data"];
      final List<UserModel> users =
          usersMap.map((product) => UserModel.fromJson(product)).toList();
      emit(GetAllUsersSuccess(users));
    });
  }

  Future<void> deleteUser(String userId) async {
    print("🚀 deleteUser called");

    emit(DeleteUserLoading());
    print("🔄 DeleteUserLoading emitted");

    final result = await _accessUserRepository.deleteUser(userId: userId);

    result.fold(
      (failure) {
        print("❌ delete failed");
        emit(DeleteUserError());
      },
      (data) {
        print("✅ delete succeeded");
        emit(DeleteUserSuccess());
      },
    );
  }

  Future<void> getUserDataById(String userId) async {
    emit(GetSpecificUserLoading());
    final result = await _accessUserRepository.getUserDataById(userId: userId);
    result.fold((l) => emit(GetSpecificUserError()), (r) {
      emit(GetSpecificUserSuccess(UserModel.fromJson(r["data"])));
    });
  }
}
