part of 'edit_category_cubit.dart';

sealed class EditCategoryState extends Equatable {
  const EditCategoryState();

  @override
  List<Object> get props => [];
}

final class EditCategoryInitial extends EditCategoryState {}

/// Generic Loading, Success, and Error
final class EditCategoryLoading extends EditCategoryState {}

final class EditCategorySuccess extends EditCategoryState {
  final String message;
  const EditCategorySuccess(this.message);
}

final class EditCategoryError extends EditCategoryState {

}

/// Step 1: update category
final class UpdateCategoryLoading extends EditCategoryState {}

final class UpdateCategorySuccess extends EditCategoryState {
  
}

final class UpdateCategoryError extends EditCategoryState {

}

/// Step 2: delete category
final class DeleteCategoryLoading extends EditCategoryState {}

final class DeleteCategorySuccess extends EditCategoryState {

}

final class DeleteCategoryError extends EditCategoryState {

}

/// Step 3: add category
final class AddCategoryLoading extends EditCategoryState {}

final class AddCategorySuccess extends EditCategoryState {

}

final class AddCategoryError extends EditCategoryState {
  
}

/// Step 4: get categories
final class GetCategoriesLoading extends EditCategoryState {}

final class GetCategoriesSuccess extends EditCategoryState {
  final List<Category> categories;
  const GetCategoriesSuccess(this.categories);
}

final class GetCategoriesError extends EditCategoryState {
 
}
