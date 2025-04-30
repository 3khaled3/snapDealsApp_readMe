import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_deals/app/product_feature/data/repositories/product_repository.dart';

part 'delete_product_state.dart';

class DeleteProductCubit extends Cubit<DeleteProductState> {
  DeleteProductCubit() : super(DeleteProductInitial());
  final ProductRepository _productRepository = ProductRepository();

  Future<void> deleteProduct(String id) async {
    emit(DeleteProductLoading());
    final result = await _productRepository.deleteProduct(id);
    result.fold((l) => emit(DeleteProductError()), (r) {
      emit(DeleteProductSuccess());
    });
  }
}
