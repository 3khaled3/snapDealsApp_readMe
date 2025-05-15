part of 'remove_from_favorite_cubit.dart';

sealed class RemoveFromFavoriteState extends Equatable {
  const RemoveFromFavoriteState();

  @override
  List<Object> get props => [];
}

final class RemoveFromFavoriteInitial extends RemoveFromFavoriteState {}
final class RemoveFromFavoriteLoading extends RemoveFromFavoriteState {}
final class RemoveFromFavoriteSuccess extends RemoveFromFavoriteState {}
final class RemoveFromFavoriteError extends RemoveFromFavoriteState {}
