import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/data/repositories/product_repository.dart';

part 'get_all_products_state.dart';

class GetAllProductsCubit extends Cubit<GetAllProductsState> {
  GetAllProductsCubit() : super(GetAllProductsInitial());

  final IProductRepository _productRepository = ProductRepository();

  Future<void> getAllProducts(
      {required String limit, required String page}) async {
    emit(GetAllProductsLoading());
    final result =
        await _productRepository.getProducts(limit: "3", page: page);
    result.fold((l) => emit(GetAllProductsError()), (r) {
      final List productsMap = r["data"];
      final List<ProductModel> products =
          productsMap.map((product) => ProductModel.fromJson(product)).toList();
      emit(GetAllProductsSuccess(products));
    });
  }
}
