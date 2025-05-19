import 'package:dartz/dartz.dart';
import 'package:snap_deals/core/utils/api_endpoints.dart';
import 'package:snap_deals/core/utils/api_handler.dart';
part 'edit_category_repository.dart';

abstract class EditCategoryRepository {
  Future<Either<FailureModel, Map<String, dynamic>>> editCategory({
    required String categoryId,
    required String categoryName,
  });
  Future<Either<FailureModel, Map<String, dynamic>>> deleteCategory({
    required String categoryId,
  });
  Future<Either<FailureModel, Map<String, dynamic>>> getAllCategoryData();

  Future<Either<FailureModel, Map<String, dynamic>>> addCategory({
    required String categoryName,
  });
}
