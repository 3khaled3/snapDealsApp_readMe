import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/home_feature/view/widgets/product_card.dart';
import 'package:snap_deals/app/home_feature/view/widgets/shimmer_product_card.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/model_view/get_all_products_cubit/get_all_products_cubit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';

class AllProductList extends StatefulWidget {
  const AllProductList({super.key});

  @override
  State<AllProductList> createState() => _AllProductListState();
}

class _AllProductListState extends State<AllProductList> {
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
        }

        return Column(
          children: [
            Expanded(
              child: PagedGridView<int, ProductModel>(
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
                  firstPageProgressIndicatorBuilder: (_) => Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: ShimmerProductCard()),
                          Expanded(child: ShimmerProductCard()),
                        ],
                      ),
                      8.ph,
                      const Row(
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
                  noItemsFoundIndicatorBuilder: (_) => const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 48, color: Colors.grey),
                        SizedBox(height: 8),
                        Text("No products found",
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
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
