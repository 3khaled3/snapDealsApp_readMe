part of 'product_repository.dart';

abstract class IProductRepository {
  Future<Either<FailureModel, Map<String, dynamic>>> getProducts({ required String limit ,required String page });
  Future<Either<FailureModel, Map<String, dynamic>>> getProductById(String id);
  Future<Either<FailureModel, Map<String, dynamic>>> getProductsByCategory(String id);
  Future<Either<FailureModel, Map<String, dynamic>>> createProduct(ProductModel product);
  Future<Either<FailureModel, Map<String, dynamic>>> updateProduct(ProductModel product);
  Future<Either<FailureModel, Map<String, dynamic>>> deleteProduct(String id);  
  Future<Either<FailureModel, Map<String, dynamic>>> increaseView(String id);  

 
}