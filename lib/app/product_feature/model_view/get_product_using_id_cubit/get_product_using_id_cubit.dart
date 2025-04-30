import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/data/repositories/product_repository.dart';

part 'get_product_using_id_state.dart';

class GetProductUsingIdCubit extends Cubit<GetProductUsingIdState> {
  GetProductUsingIdCubit() : super(GetProductUsingIdInitial());
  final IProductRepository _productRepository = ProductRepository();

  Future<void> getProductUsingId(String id) async {
    emit(GetProductUsingIdLoading());
    final result = await _productRepository.getProductById(id);
    result.fold((l) => emit(GetProductUsingIdError()), (r) {
      emit(GetProductUsingIdSuccess(ProductModel.fromJson(r["data"])));
    });
  }
}
