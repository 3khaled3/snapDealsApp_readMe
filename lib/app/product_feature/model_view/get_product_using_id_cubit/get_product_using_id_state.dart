part of 'get_product_using_id_cubit.dart';

sealed class GetProductUsingIdState extends Equatable {
  const GetProductUsingIdState();

  @override
  List<Object> get props => [];
}

final class GetProductUsingIdInitial extends GetProductUsingIdState {}

final class GetProductUsingIdLoading extends GetProductUsingIdState {}

final class GetProductUsingIdSuccess extends GetProductUsingIdState {
  final ProductModel product;
  const GetProductUsingIdSuccess(this.product);
}

final class GetProductUsingIdError extends GetProductUsingIdState {}
