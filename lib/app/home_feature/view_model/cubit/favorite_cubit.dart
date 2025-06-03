import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:snap_deals/app/home_feature/view_model/favorite_local_storage.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/data/repositories/i_course_repository.dart';
import 'package:snap_deals/app/product_feature/data/repositories/product_repository.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial()) {
    // Load favorites when cubit is initialized
    loadFavorites();

    // Listen to changes in local storage
    FavoriteLocalStorage.favoriteIdsStreamMapped.listen((favoriteIds) {
      favoriteIdsSaved.value = favoriteIds;
      emit(FavoriteLoaded(products: _products, courses: _courses));
    });
  }

  ValueNotifier<List<String>> favoriteIdsSaved = ValueNotifier([]);
  List<ProductModel> _products = [];
  List<CourseModel> _courses = [];
  addCourseToFavorite(CourseModel course) {
    _courses.add(course);
  }

  addProductToFavorite(ProductModel product) {
    _products.add(product);
  }

  /// Manually populate products and courses when available
  void setAllItems({
    required List<ProductModel> products,
    required List<CourseModel> courses,
  }) {
    _products = products;
    _courses = courses;
    emit(FavoriteLoaded(products: _products, courses: _courses));
  }

  Future<void> loadFavorites() async {
    log("🚀 Starting to load favorites...");
    emit(FavoriteLoading());

    // Step 1: Clear state
    _products.clear();
    _courses.clear();

    // Step 2: Load favorite IDs
    final localFavorites = FavoriteLocalStorage.getFavoriteIds();
    favoriteIdsSaved.value = List<String>.from(localFavorites);

    final productRepo = ProductRepository();
    final courseRepo = CourseRepository();

    // Step 3: Process favorites
    for (var id in favoriteIdsSaved.value) {
      if (id.startsWith("productID")) {
        final productId = id.replaceFirst("productID", "");
        await _loadProduct(productId, productRepo);
      } else if (id.startsWith("courseID")) {
        final courseId = id.replaceFirst("courseID", "");
        await _loadCourse(courseId, courseRepo);
      }
    }

    log("✅ Products loaded: ${_products.length}");
    log("✅ Courses loaded: ${_courses.length}");
    emit(FavoriteLoaded(products: _products, courses: _courses));
  }

// Helper to load product
  Future<void> _loadProduct(String productId, IProductRepository repo) async {
    if (_products.any((p) => p.id == productId)) return;

    try {
      final result = await repo.getProductById(productId);
      result.fold(
        (l) => log("❌ Product $productId not found."),
        (r) {
          final product = ProductModel.fromJson(r["data"]);
          if (!_products.any((p) => p.id == product.id)) {
            _products.add(product);
          }
        },
      );
    } catch (e) {
      debugPrint("❌ Error fetching product $productId: $e");
    }
  }

// Helper to load course
  Future<void> _loadCourse(String courseId, ICourseRepository repo) async {
    if (_courses.any((c) => c.id == courseId)) return;

    try {
      final result = await repo.getCourseById(courseId);
      result.fold(
        (l) => log("❌ Course $courseId not found."),
        (r) {
          final course = CourseModel.fromJson(r["data"]);
          if (!_courses.any((c) => c.id == course.id)) {
            _courses.add(course);
          }
        },
      );
    } catch (e) {
      debugPrint("❌ Error fetching course $courseId: $e");
    }
  }

  Future<void> toggleFavorite(String productId, dynamic item) async {
    late final String fullId;
    if (item is ProductModel) {
      fullId = "productID$productId";
    } else if (item is CourseModel) {
      fullId = "courseID$productId";
    } else {
      throw Exception("Unsupported item type");
    }

    final isFav = FavoriteLocalStorage.isFavorite(fullId);

    if (isFav) {
      await FavoriteLocalStorage.removeFavoriteId(fullId);

      if (item is ProductModel) {
        _products.removeWhere((p) => p.id == productId);
      } else if (item is CourseModel) {
        _courses.removeWhere((c) => c.id == productId);
      }
    } else {
      await FavoriteLocalStorage.addFavoriteId(fullId);

      if (item is ProductModel && !_products.any((p) => p.id == productId)) {
        _products.add(item);
      } else if (item is CourseModel &&
          !_courses.any((c) => c.id == productId)) {
        _courses.add(item);
      }
    }

    favoriteIdsSaved.value = FavoriteLocalStorage.getFavoriteIds();
    log("🚀🚀🚀🚀🚀 favoriteIdsSaved: ${favoriteIdsSaved.value}");

    emit(FavoriteLoaded(products: _products, courses: _courses));
  }

  bool isFavorite(bool isProduct, String productId) => favoriteIdsSaved.value
      .contains(isProduct ? "productID$productId" : "courseID$productId");
}
