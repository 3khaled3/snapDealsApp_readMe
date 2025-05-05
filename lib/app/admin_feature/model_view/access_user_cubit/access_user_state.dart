part of 'access_user_cubit.dart';

sealed class AccessUserState extends Equatable {
  const AccessUserState();

  @override
  List<Object> get props => [];
}

// Initial State
final class AccessUserInitial extends AccessUserState {}
final class AccessUserLoading extends AccessUserState {}
final class AccessUserError extends AccessUserState {}
final class AccessUserSuccess extends AccessUserState {}

// Get All Users
final class GetAllUsersLoading extends AccessUserState {}
final class GetAllUsersError extends AccessUserState {}
final class GetAllUsersSuccess extends AccessUserState {
   final List<UserModel> users;
  const GetAllUsersSuccess(this.users);
}

// Delete User
final class DeleteUserLoading extends AccessUserState {}
final class DeleteUserError extends AccessUserState {}
final class DeleteUserSuccess extends AccessUserState {}

// Get Specific User
final class GetSpecificUserLoading extends AccessUserState {}
final class GetSpecificUserError extends AccessUserState {}
final class GetSpecificUserSuccess extends AccessUserState {
  final UserModel user;
  const GetSpecificUserSuccess(this.user);
}


