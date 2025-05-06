part of 'get_sup_user_cubit.dart';

sealed class GetSupUserState extends Equatable {
  const GetSupUserState();

  @override
  List<Object> get props => [];
}

final class GetSupUserInitial extends GetSupUserState {}

final class GetSupUserLoading extends GetSupUserState {}

final class GetSupUserSuccess extends GetSupUserState {
  final Partner user;
  const GetSupUserSuccess({required this.user});
}

final class GetSupUserError extends GetSupUserState {
  final String message;
  const GetSupUserError({required this.message});
}
