import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:snap_deals/app/home_feature/view_model/favorite_local_storage.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial()) {
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
    emit(FavoriteLoading());
    final localFavorites = FavoriteLocalStorage.getFavoriteIds();
    favoriteIdsSaved.value = List<String>.from(localFavorites);
    emit(FavoriteLoaded(products: _products, courses: _courses));
  }

  Future<void> toggleFavorite(String productId, dynamic item) async {
    final isFav = FavoriteLocalStorage.isFavorite(productId);

    if (isFav) {
      // Remove from local storage and from UI list
      await FavoriteLocalStorage.removeFavoriteId(productId);

      if (item is ProductModel) {
        _products.removeWhere((p) => p.id == productId);
      } else if (item is CourseModel) {
        _courses.removeWhere((c) => c.id == productId);
      }
    } else {
      // Add to local storage and to UI list
      await FavoriteLocalStorage.addFavoriteId(productId);

      if (item is ProductModel && !_products.any((p) => p.id == productId)) {
        _products.add(item);
      } else if (item is CourseModel &&
          !_courses.any((c) => c.id == productId)) {
        _courses.add(item);
      }
    }

    favoriteIdsSaved.value = FavoriteLocalStorage.getFavoriteIds();
    emit(FavoriteLoaded(products: _products, courses: _courses));
  }

  bool isFavorite(String productId) =>
      favoriteIdsSaved.value.contains(productId);
}
