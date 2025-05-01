import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_deals/app/admin_feature/data/repositories/i_edit_category_repository.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';

part 'edit_category_state.dart';

class EditCategoryCubit extends Cubit<EditCategoryState> {
  EditCategoryCubit() : super(EditCategoryInitial());
  final _categoryRepository = EditCategoryRepositoryImpl();

  Future<void> getAllCategoryData () async{
    emit(GetCategoriesLoading());
    final result = await _categoryRepository.getAllCategoryData();
    result.fold((l) => emit(GetCategoriesError()), (r) {
      final List
       categoriesMap = r["data"];
      final List<Category> categories =
          categoriesMap.map((category) => Category.fromJson(category)).toList();
      emit(GetCategoriesSuccess(categories));
    });
  }

   Future<void> addCategory(String name) async {
    emit(AddCategoryLoading());

    final result =
        await _categoryRepository.addCategory(categoryName: name);

    result.fold(
      (failure) => emit(AddCategoryError()),
      (data) => emit(AddCategorySuccess()),
    );
  }

  Future<void> deleteCategory(String categoryId) async {
    emit(DeleteCategoryLoading());

    final result =
        await _categoryRepository.deleteCategory(categoryId: categoryId);

    result.fold(
      (failure) => emit(DeleteCategoryError()),
      (data) => emit(DeleteCategorySuccess()),
    );
  }

  Future<void> updateCategory(String categoryId, String name) async {
    emit(UpdateCategoryLoading());

    final result =
        await _categoryRepository.editCategory(categoryId: categoryId, categoryName: name);

    result.fold(
      (failure) => emit(UpdateCategoryError()),
      (data) => emit(UpdateCategorySuccess()),
    );
  }
}
