part of "profile_cubit.dart";

sealed class ProfileStates {
  final UserModel profile;

  const ProfileStates(this.profile);
}

final class ProfileInitial extends ProfileStates {
  const ProfileInitial(super.profile);
}

final class ProfileLoading extends ProfileStates {
  const ProfileLoading(super.profile);
}

final class ProfileSuccess extends ProfileStates {
  const ProfileSuccess(super.profile);
}

final class ProfileError extends ProfileStates {
  const ProfileError(super.profile);
}

final class DeleteUserLoading extends ProfileStates {
  const DeleteUserLoading(super.profile);
}

final class DeleteUserSuccess extends ProfileStates {
  const DeleteUserSuccess(super.profile);
}

final class DeleteUserError extends ProfileStates {
  const DeleteUserError(super.profile);
}

final nonRegisteredUser = UserModel(
  id: 'mock',
  name: 'mock',
  slug: 'mock',
  email: 'testuser@example.com',
  phone: '01000000000',
  profileImg: 'default.jpg',
  role: Role.unregistered,
  active: true,
  createdAt: DateTime.now().subtract(const Duration(days: 1)),
  updatedAt: DateTime.now(),
);
