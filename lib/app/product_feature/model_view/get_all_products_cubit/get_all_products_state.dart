part of 'get_all_products_cubit.dart';

sealed class GetAllProductsState extends Equatable {
  const GetAllProductsState();

  @override
  List<Object> get props => [];
}

final class GetAllProductsInitial extends GetAllProductsState {}

final class GetAllProductsSuccess extends GetAllProductsState {
  final List<ProductModel> products;
  const GetAllProductsSuccess(this.products);
}

final class GetAllProductsError extends GetAllProductsState {}

final class GetAllProductsLoading extends GetAllProductsState {}
