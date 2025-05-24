import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/data/repositories/product_repository.dart';

part 'get_my_products_state.dart';

class GetMyProductsCubit extends Cubit<GetMyProductsState> {
  GetMyProductsCubit() : super(GetMyProductsInitial());

  final IProductRepository _productRepository = ProductRepository();

  Future<void> getMyProducts(
      {required String limit, required String page,required String uesrId}) async {
    emit(GetMyProductsLoading());
    final result =
        await _productRepository.getMyProducts(limit: "4", page: page,uesrId: uesrId);
    result.fold((l) => emit(GetMyProductsError()), (r) {
      final List productsMap = r["data"];
      final List<ProductModel> products =
          productsMap.map((product) => ProductModel.fromJson(product)).toList();
      emit(GetMyProductsSuccess(products));
    });
  }
}
