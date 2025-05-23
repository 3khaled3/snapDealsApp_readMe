import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/home_feature/view/widgets/product_card.dart';
import 'package:snap_deals/app/home_feature/view/widgets/shimmer_product_card.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/model_view/get_all_products_cubit/get_all_products_cubit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PopularProductBuilder extends StatefulWidget {
  const PopularProductBuilder({super.key});

  @override
  State<PopularProductBuilder> createState() => _PopularProductBuilderState();
}

class _PopularProductBuilderState extends State<PopularProductBuilder> {
  int _nextPageKey = 1;
  final PagingController<int, ProductModel> _pagingController =
      PagingController(firstPageKey: 1);

  late GetAllProductsCubit _productCubit;

  @override
  void initState() {
    super.initState();

    _productCubit = GetAllProductsCubit();
    _pagingController.addPageRequestListener((pageKey) {
      _productCubit.getAllProducts(limit: "20", page: pageKey.toString());
    });
  }

  Future<void> _handleFetchedProducts(List<ProductModel> products) async {
    try {
      final isLastPage = products.isEmpty;

      if (isLastPage) {
        _pagingController.appendLastPage(products);
      } else {
        _nextPageKey++;
        _pagingController.appendPage(products, _nextPageKey);
      }
      print('Added new items');
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllProductsCubit, GetAllProductsState>(
      bloc: _productCubit,
      builder: (context, state) {
        if (state is GetAllProductsSuccess) {
          _handleFetchedProducts(state.products);
        } else if (state is GetAllProductsError) {
          _pagingController.error = "Something went wrong";
        }
        return SizedBox(
          height: 276,
          child: PagedListView<int, ProductModel>(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 8),
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<ProductModel>(
              itemBuilder: (context, product, index) => Padding(
                padding: EdgeInsets.zero,
                child: ProductCard(product: product),
              ),
              firstPageErrorIndicatorBuilder: (_) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Something went wrong. Please try again."),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => _pagingController.refresh(),
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              ),
              firstPageProgressIndicatorBuilder: (_) => const Row(
                children: [
                  Expanded(child: ShimmerProductCard()),
                  SizedBox(width: 8),
                  Expanded(child: ShimmerProductCard()),
                ],
              ),
              newPageProgressIndicatorBuilder: (_) =>
                  const Center(child: ShimmerProductCard()),
              noItemsFoundIndicatorBuilder: (_) => const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 48, color: Colors.grey),
                    SizedBox(width: 8),
                    Text("No products found",
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
