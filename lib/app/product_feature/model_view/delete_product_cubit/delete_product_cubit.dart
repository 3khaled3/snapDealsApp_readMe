import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_deals/app/product_feature/data/repositories/i_course_repository.dart';
import 'package:snap_deals/app/product_feature/data/repositories/product_repository.dart';

part 'delete_product_state.dart';

class DeleteProductCubit extends Cubit<DeleteProductState> {
  DeleteProductCubit() : super(DeleteProductInitial());
  final ProductRepository _productRepository = ProductRepository();

  final CourseRepository _courseRepository = CourseRepository();

  Future<void> deleteCourse(String id) async {
    emit(DeleteCourseLoading());
    final result = await _courseRepository.deleteCourse(id);
    result.fold((l) => emit(DeleteCourseError()), (r) {
      emit(DeleteCourseSuccess());
    });
  }
  Future<void> deleteProduct(String id) async {
    emit(DeleteProductLoading());
    final result = await _productRepository.deleteProduct(id);
    result.fold((l) => emit(DeleteProductError()), (r) {
      emit(DeleteProductSuccess());
    });
  }
}
