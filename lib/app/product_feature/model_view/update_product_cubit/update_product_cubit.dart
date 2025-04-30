import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/data/repositories/product_repository.dart';

part 'update_product_state.dart';

class UpdateProductCubit extends Cubit<UpdateProductState> {
  UpdateProductCubit() : super(UpdateProductInitial());
  final IProductRepository _productRepository = ProductRepository();
  Future<void> updateProduct(ProductModel product) async {
    emit(UpdateProductLoading());
    final result = await _productRepository.updateProduct(product);
    result.fold((l) => emit(UpdateProductError()), (r) {
      emit(UpdateProductSuccess());
    });
  }
}
