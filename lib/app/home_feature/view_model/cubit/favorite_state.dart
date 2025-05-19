part of 'favorite_cubit.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<ProductModel> products;
  final List<CourseModel> courses;

  FavoriteLoaded({
    required this.products,
    required this.courses,
  });
}

class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError(this.message);
}
