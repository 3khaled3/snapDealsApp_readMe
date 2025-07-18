import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/core/utils/api_endpoints.dart';
import 'package:snap_deals/core/utils/api_handler.dart';

part "i_product_repository.dart";

class ProductRepository implements IProductRepository {
  @override
  Future<Either<FailureModel, Map<String, dynamic>>> createProduct(
      ProductModel product, XFile image) async {
    print("createProduct called with image: ${product.createProductJson()}");
    return HttpHelper.handleRequest(
      (token) => HttpHelper.postFile(
        name: "images",
        file: File(image.path),
        linkUrl: ApiEndpoints.products,
        field: product.createProductJson(),
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
  Future<Either<FailureModel, Map<String, dynamic>>> getMyProducts(
      {required String limit, required String page, required String uesrId}) {
    return HttpHelper.handleRequest(
      (token) => HttpHelper.getData(
        linkUrl:
            "${ApiEndpoints.products}?page=$page&limit=$limit&user=$uesrId",
        token: token,
      ),
    );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> getProductsByCategory(
      {required String limit, required String page, required String id}) {
    return HttpHelper.handleRequest(
      (token) => HttpHelper.getData(
        linkUrl:
            "${ApiEndpoints.products}?page=$page&limit=$limit&category=$id",
        token: token,
      ),
    );
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
      ProductModel product, Map<String, dynamic> data) async {
    return HttpHelper.handleRequest(
      (token) => HttpHelper.putData(
        linkUrl: ApiEndpoints.productById(product.id),
        token: token,
        data: data,
      ),
    );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> getProductBySearch(
      String title) {
    return HttpHelper.handleRequest(
      (token) => HttpHelper.getData(
        linkUrl: ApiEndpoints.getProductBySearch(title),
        token: token,
      ),
    );
  }
}
