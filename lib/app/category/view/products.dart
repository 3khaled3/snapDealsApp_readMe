import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:snap_deals/app/home_feature/view/widgets/product_card.dart';
import 'package:snap_deals/app/home_feature/view/widgets/shimmer_product_card.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/model_view/get-products_by_category/get_products_by_category_cubit.dart';

class ProductsByCategoryList extends StatefulWidget {
  final String id; // category ID

  const ProductsByCategoryList({super.key, required this.id});

  @override
  State<ProductsByCategoryList> createState() => _ProductsByCategoryListState();
}

class _ProductsByCategoryListState extends State<ProductsByCategoryList> {
  int _nextPageKey = 1;
  final int _limit = 20;
  final PagingController<int, ProductModel> _pagingController =
      PagingController(firstPageKey: 1);

  late GetProductsByCategoryCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = GetProductsByCategoryCubit();

    _pagingController.addPageRequestListener((pageKey) {
      _cubit.getProductsByCategory(
        page: pageKey.toString(),
        limit: _limit.toString(),
        id: widget.id,
      );
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
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProductsByCategoryCubit, GetProductsByCategoryState>(
      bloc: _cubit,
      builder: (context, state) {
        if (state is GetProductsByCategorySuccess) {
          _handleFetchedProducts(state.products);
        }

        return PagedGridView<int, ProductModel>(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.66,
          ),
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<ProductModel>(
            itemBuilder: (context, product, index) => Padding(
              padding: EdgeInsets.zero,
              child: ProductCard(product: product),
            ),
            firstPageProgressIndicatorBuilder: (_) => const Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: ShimmerProductCard()),
                    Expanded(child: ShimmerProductCard()),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: ShimmerProductCard()),
                    Expanded(child: ShimmerProductCard()),
                  ],
                ),
              ],
            ),
            newPageProgressIndicatorBuilder: (_) =>
                const Center(child: ShimmerProductCard()),
            firstPageErrorIndicatorBuilder: (_) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ShimmerProductCard(),
                  const SizedBox(height: 16),
                  const Text("Something went wrong. Please try again."),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => _pagingController.refresh(),
                    child: const Text("Retry"),
                  ),
                ],
              ),
            ),
            noItemsFoundIndicatorBuilder: (_) => const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 48, color: Colors.grey),
                  SizedBox(height: 8),
                  Text("No products in this category",
                      style: TextStyle(color: Colors.grey)),
                ],
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
