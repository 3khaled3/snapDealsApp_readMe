import 'dart:io';
import 'dart:convert';

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
      {required String limit, required String page,required String uesrId}) {
    return HttpHelper.handleRequest(
      (token) => HttpHelper.getData(
        linkUrl: "${ApiEndpoints.products}?page=$page&limit=$limit&user=$uesrId",
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
    ProductModel product, XFile? image) async {
    
    print('=== UPDATE PRODUCT REQUEST ===');
    print('Product ID: ${product.id}');
    print('Product Title: ${product.title}');
    print('Product Price: ${product.price}');
    print('Product Location: ${product.location}');
    print('Product Description: ${product.description}');
    print('Product Slug: ${product.slug}');
    print('Product Category: ${product.category.name} (ID: ${product.category.id})');
    print('Product Details: ${product.details}');
    print('Product Images: ${product.images}');
    print('Has Image File: ${image != null}');
    print('API Endpoint: ${ApiEndpoints.productById(product.id)}');
    
    final requestData = product.createProductJson();
    print('Request Data: $requestData');
    
    return HttpHelper.handleRequest(
      (token) async {
        print('Making PUT request to: ${ApiEndpoints.productById(product.id)}');
        print('With token: ${token?.substring(0, 20)}...');
        
        final result = await HttpHelper.putFile(
          linkUrl: ApiEndpoints.productById(product.id),
          name: "images",
          token: token,
          file: image != null ? File(image.path) : null,
          field: requestData,
        );
        
        print('=== UPDATE PRODUCT RESPONSE ===');
        print('Response: $result');
        
        // Log the actual response data
        try {
          print('Response Status Code: ${result.statusCode}');
          print('Response Headers: ${result.headers}');
          print('Response Body: ${result.body}');
          
          // Try to parse the response body as JSON
          if (result.body.isNotEmpty) {
            final responseData = jsonDecode(result.body);
            print('Parsed Response Data: $responseData');
            if (responseData.containsKey('data')) {
              final productData = responseData['data'];
              print('Updated Product Data:');
              print('  Title: ${productData['title']}');
              print('  Price: ${productData['price']}');
              print('  Location: ${productData['location']}');
              print('  Description: ${productData['description']}');
            }
          }
        } catch (e) {
          print('Error parsing response: $e');
        }
        
        return result;
      },
    );
  }

}
