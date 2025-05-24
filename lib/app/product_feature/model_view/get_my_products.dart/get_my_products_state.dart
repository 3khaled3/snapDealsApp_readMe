part of 'get_my_products_cubit.dart';

sealed class GetMyProductsState extends Equatable {
  const GetMyProductsState();

  @override
  List<Object> get props => [];
}

final class GetMyProductsInitial extends GetMyProductsState {}
 
 final class GetMyProductsLoading extends GetMyProductsState {}
 
 final class GetMyProductsSuccess extends GetMyProductsState {
   final List<ProductModel> products;
   const GetMyProductsSuccess(this.products);
 }
 
 final class GetMyProductsError extends GetMyProductsState {}