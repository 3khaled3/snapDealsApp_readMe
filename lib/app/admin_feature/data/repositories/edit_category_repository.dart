part of 'i_edit_category_repository.dart';

class EditCategoryRepositoryImpl implements EditCategoryRepository {
  @override
  Future<Either<FailureModel, Map<String, dynamic>>> addCategory({
    required String categoryName,
  }) async {
    return await HttpHelper.handleRequest(
      (token) => HttpHelper.postData(
        linkUrl: ApiEndpoints.categories,
        data: {
          "name": categoryName,
        },
        token: token,
      ),
    );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> editCategory({
    required String categoryId,
    required String categoryName,
  }) async {
    return await HttpHelper.handleRequest(
      (token) => HttpHelper.putData(
        linkUrl: ApiEndpoints.categoryById(categoryId),
        data: {
          "name": categoryName,
        },
        token: token,
      ),
    );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> deleteCategory({
    required String categoryId,
  }) async {
    return await HttpHelper.handleRequest(
      (token) => HttpHelper.deleteData(
        linkUrl: ApiEndpoints.categoryById(categoryId),
        token: token,
      ),
    );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>>
      getAllCategoryData() async {
    return await HttpHelper.handleRequest(
      (token) => HttpHelper.getData(
        linkUrl: ApiEndpoints.categories,
        token: token,
      ),
    );
  }
}
