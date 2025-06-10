part of 'delete_product_cubit.dart';

sealed class DeleteProductState extends Equatable {
  const DeleteProductState();

  @override
  List<Object> get props => [];
}

final class DeleteProductInitial extends DeleteProductState {}

final class DeleteProductLoading extends DeleteProductState {}

final class DeleteProductSuccess extends DeleteProductState {}

final class DeleteProductError extends DeleteProductState {}


final class DeleteCourseInitial extends DeleteProductState {}

final class DeleteCourseLoading extends DeleteProductState {}

final class DeleteCourseSuccess extends DeleteProductState {}

final class DeleteCourseError extends DeleteProductState {}