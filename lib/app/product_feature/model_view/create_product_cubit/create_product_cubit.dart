import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/data/repositories/product_repository.dart';

part 'create_product_state.dart';

class CreateProductCubit extends Cubit<CreateProductState> {
  CreateProductCubit() : super(CreateProductInitial());
  final _productRepository = ProductRepository();

  Future<void> createProduct(ProductModel product, XFile image) async {
    emit(CreateProductLoading());
    final result = await _productRepository.createProduct(product, image);
    result.fold((l) => emit(CreateProductError()), (r) {
      emit(CreateProductSuccess());
    });
  }
}
