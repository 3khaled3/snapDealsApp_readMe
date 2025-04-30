import 'package:dartz/dartz.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/core/utils/api_endpoints.dart';
import 'package:snap_deals/core/utils/api_handler.dart';

part "i_product_repository.dart";

class ProductRepository implements IProductRepository {
  @override
  Future<Either<FailureModel, Map<String, dynamic>>> createProduct(
      ProductModel product) async {
    return HttpHelper.handleRequest(
      (token) => HttpHelper.postData(
        linkUrl: ApiEndpoints.products,
        data: product.toJson(),
        token: token,
      ),
    );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> getProductById(String id) {
    return HttpHelper.handleRequest(
      (token) => HttpHelper.getData(
        linkUrl: ApiEndpoints.productById(id),
        token: token,
      ),
    );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> getProducts(
      {required String limit, required String page}) {
    return HttpHelper.handleRequest(
      (token) => HttpHelper.getData(
        linkUrl: "${ApiEndpoints.products}?page=$page&limit=$limit",
        token: token,
      ),
    );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> getProductsByCategory(
      String id) {
    // TODO: implement getProductsByCategory
    throw UnimplementedError();
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> increaseView(String id) {
    return HttpHelper.handleRequest(
      (token) => HttpHelper.patchData(
        data: {},
        linkUrl: ApiEndpoints.productViews(id),
        token: token,
      ),
    );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> deleteProduct(String id) {
    return HttpHelper.handleRequest(
      (token) => HttpHelper.deleteData(
        linkUrl: ApiEndpoints.productById(id),
        token: token,
      ),
    );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> updateProduct(
      ProductModel product) {
    return HttpHelper.handleRequest(
      (token) => HttpHelper.putData(
        linkUrl: ApiEndpoints.productById(product.id),
        data: product.toJson(),
        token: token,
      ),
    );
  }
}
