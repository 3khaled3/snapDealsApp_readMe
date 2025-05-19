part of 'get_favorite_cubit.dart';

abstract class GetFavoriteState extends Equatable {
  const GetFavoriteState();

  @override
  List<Object> get props => [];
}

class GetFavoriteInitial extends GetFavoriteState {}

class GetFavoriteLoading extends GetFavoriteState {}

class GetFavoriteSuccess extends GetFavoriteState {
  final List<ProductModel> products;
  final List<CourseModel> courses;
  const GetFavoriteSuccess({
    required this.products,
    required this.courses,
  });
}

class GetFavoriteError extends GetFavoriteState {}
