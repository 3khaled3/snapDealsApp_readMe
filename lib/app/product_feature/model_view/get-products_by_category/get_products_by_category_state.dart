part of 'get_products_by_category_cubit.dart';

abstract class GetProductsByCategoryState extends Equatable {
  const GetProductsByCategoryState();

  @override
  List<Object> get props => [];
}

class GetProductsByCategoryInitial extends GetProductsByCategoryState {}
class GetProductsByCategoryLoading extends GetProductsByCategoryState {}
class GetProductsByCategorySuccess extends GetProductsByCategoryState {
  final List<ProductModel> products;
  
  const GetProductsByCategorySuccess(this.products);

  
}
class GetProductsByCategoryError extends GetProductsByCategoryState {}
