part of 'add_to_favorite_cubit.dart';

sealed class AddToFavoriteState extends Equatable {
  const AddToFavoriteState();

  @override
  List<Object> get props => [];
}

final class AddToFavoriteInitial extends AddToFavoriteState {}

final class AddToFavoriteLoading extends AddToFavoriteState {}

final class AddToFavoriteSuccess extends AddToFavoriteState {}

final class AddToFavoriteError extends AddToFavoriteState {}
