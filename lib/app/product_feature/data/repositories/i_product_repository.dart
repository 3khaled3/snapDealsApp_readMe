part of 'product_repository.dart';

abstract class IProductRepository {
  Future<Either<FailureModel, Map<String, dynamic>>> getProducts(
      {required String limit, required String page});
  Future<Either<FailureModel, Map<String, dynamic>>> getMyProducts(
      {required String limit, required String page, required String uesrId});
  Future<Either<FailureModel, Map<String, dynamic>>> getProductById(String id);
  Future<Either<FailureModel, Map<String, dynamic>>> getProductsByCategory(
      {required String limit, required String page, required String id});
  Future<Either<FailureModel, Map<String, dynamic>>> createProduct(
      ProductModel product, XFile image);
  Future<Either<FailureModel, Map<String, dynamic>>> updateProduct(
      ProductModel product, Map<String, dynamic> data);
  Future<Either<FailureModel, Map<String, dynamic>>> deleteProduct(String id);
  Future<Either<FailureModel, Map<String, dynamic>>> increaseView(String id);
}
