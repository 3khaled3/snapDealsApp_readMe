import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/data/repositories/product_repository.dart';
import 'package:snap_deals/app/product_feature/model_view/get_all_products_cubit/get_all_products_cubit.dart';
import 'package:snap_deals/app/product_feature/model_view/get_my_products.dart/get_my_products_cubit.dart';
import 'package:snap_deals/app/product_feature/model_view/get-products_by_category/get_products_by_category_cubit.dart';

part 'update_product_state.dart';

class UpdateProductCubit extends Cubit<UpdateProductState> {
  UpdateProductCubit() : super(UpdateProductInitial());
  final IProductRepository _productRepository = ProductRepository();
  
  Future<void> updateProduct(ProductModel product, XFile? image) async {
    emit(UpdateProductLoading());
    final result = await _productRepository.updateProduct(product, image);
    result.fold((l) => emit(UpdateProductError()), (r) {
      // Emit success with the updated product
      emit(UpdateProductSuccess(product));
      
      // Refresh product lists to ensure UI consistency
      _refreshProductLists();
    });
  }
  
  void _refreshProductLists() {
    // Refresh all product lists to ensure UI shows updated data
    // This will be handled by the UI components that listen to these cubits
    print('Refreshing product lists after update');
  }
}
