import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:snap_deals/app/home_feature/data/repositories/favorite/i_favorite_repository.dart';
import 'package:snap_deals/app/home_feature/view_model/favorite_local_storage.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final IFavoriteRepository repository = FavoriteRepository();

  FavoriteCubit() : super(FavoriteInitial()) {
    // Listen to local storage changes and emit new state
    FavoriteLocalStorage.favoriteIdsStreamMapped.listen((favoriteIds) {
      if (state is FavoriteLoaded) {
        emit(FavoriteLoaded(products: _products, courses: _courses));
      }
    });
  }

  ValueNotifier<List<String>> favoriteIdsSaved = ValueNotifier([]);
  List<ProductModel> _products = [];
  List<CourseModel> _courses = [];

  Future<void> loadFavorites() async {
    emit(FavoriteLoading());

    final localFavorites = FavoriteLocalStorage.getFavoriteIds();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      favoriteIdsSaved.value = List<String>.from(localFavorites);
    });

    emit(FavoriteLoaded(products: _products, courses: _courses));

    final result = await repository.getFavorites();

    result.fold(
      (failure) {
        emit(FavoriteError(failure.message ?? 'Failed to load favorites.'));
      },
      (data) async {
        final List<dynamic> items = data['data'];

        List<ProductModel> productList = [];
        List<CourseModel> courseList = [];
        List<String> favoriteIds = [];

        for (final item in items) {
          final id = item["_id"].toString();
          favoriteIds.add(id);

          if (item.containsKey("lessons")) {
            courseList.add(CourseModel.fromJson(item));
          } else {
            productList.add(ProductModel.fromJson(item));
          }

          await FavoriteLocalStorage.addFavoriteId(id);
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          favoriteIdsSaved.value = favoriteIds;
        });

        _products = productList;
        _courses = courseList;

        emit(FavoriteLoaded(products: _products, courses: _courses));
      },
    );
  }

  Future<void> toggleFavorite(String productId) async {
    final isFav = FavoriteLocalStorage.isFavorite(productId);

    // Optimistic update
    if (isFav) {
      await FavoriteLocalStorage.removeFavoriteId(productId);
      _courses.removeWhere((c) => c.id == productId);
      _products.removeWhere((p) => p.id == productId);
    } else {
      await FavoriteLocalStorage.addFavoriteId(productId);
    }

    // Reflect optimistic update in UI
    final updatedIds = FavoriteLocalStorage.getFavoriteIds();
    favoriteIdsSaved.value = updatedIds;

    emit(FavoriteLoaded(products: _products, courses: _courses));

    final result = isFav
        ? await repository.removeFromFavorites(productId)
        : await repository.addToFavorites(productId);

    result.fold(
      (failure) async {
        // Revert optimistic update on error
        if (isFav) {
          await FavoriteLocalStorage.addFavoriteId(productId);
        } else {
          await FavoriteLocalStorage.removeFavoriteId(productId);
          _courses.removeWhere((c) => c.id == productId);
          _products.removeWhere((p) => p.id == productId);
        }

        favoriteIdsSaved.value = FavoriteLocalStorage.getFavoriteIds();

        emit(FavoriteError(failure.message ?? 'Something went wrong.'));
      },
      (data) async {
        // After a successful add/remove, reload the favorites from backend
        await loadFavorites();
      },
    );
  }

  bool isFavorite(String productId) =>
      favoriteIdsSaved.value.contains(productId);
}
