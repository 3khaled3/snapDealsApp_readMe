import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/data/repositories/product_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Future<void> searchProduct(String query) async {
    if (query.isEmpty || query.trim().isEmpty) {
      log("query is empty");
      emit(SearchLoading()); 
      emit(const SearchSuccess(products: []));
      return;
    }
    emit(SearchLoading());
    final repo = ProductRepository();
    final result = await repo.getProductBySearch(query);

    result.fold((l) => emit(SearchError()), (r) {
      final List productsMap = r["data"];
      final List<ProductModel> products =
          productsMap.map((product) => ProductModel.fromJson(product)).toList();
      log("products.length ${products.length}");
      emit(SearchSuccess(products: products));
    });
  }
}
