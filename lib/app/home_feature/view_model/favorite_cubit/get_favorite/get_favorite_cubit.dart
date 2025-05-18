import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_deals/app/home_feature/data/repositories/favorite/i_favorite_repository.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';

part 'get_favorite_state.dart';

class GetFavoriteCubit extends Cubit<GetFavoriteState> {
  GetFavoriteCubit() : super(GetFavoriteInitial());
    final _favoriteRepository = FavoriteRepository();
    
    
    Future<void> getFavorites() async {
  emit(GetFavoriteLoading());

  final result = await _favoriteRepository.getFavorites();
  result.fold(
    (l) => emit(GetFavoriteError()),
    (r) {
      final List<dynamic> productsMap = r["data"];

       List<ProductModel> productList = [];
       List<CourseModel> courseList = [];

      for (final item in productsMap) {
          print("Item type: ${item.containsKey("lessons") ? "Course" : "Product"}");
        if (item.containsKey('lessons')) {
          // Course
          courseList.add(CourseModel.fromJson(item));
        } else {
          // Product
          productList.add(ProductModel.fromJson(item));
        }
      }

      emit(GetFavoriteSuccess(
        products: productList,
        courses: courseList,
      ));
    },
  );
}

}
