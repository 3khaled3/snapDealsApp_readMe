import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/data/repositories/product_repository.dart';

part 'get_products_by_category_state.dart';

class GetProductsByCategoryCubit extends Cubit<GetProductsByCategoryState> {
  GetProductsByCategoryCubit() : super(GetProductsByCategoryInitial());
  final IProductRepository _productRepository = ProductRepository();

  Future<void> getProductsByCategory(
      {required String limit, required String page, required String id}) async {
    emit(GetProductsByCategoryLoading());
    final result =
        await _productRepository.getProductsByCategory(limit: limit, page: page, id: id);
    result.fold((l) => emit(GetProductsByCategoryError()), (r) {
      final List productsMap = r["data"];
      final List<ProductModel> products =
          productsMap.map((product) => ProductModel.fromJson(product)).toList();
      emit(GetProductsByCategorySuccess(products));
    });
  }
}
