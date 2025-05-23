import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/home_feature/view/widgets/product_card.dart';
import 'package:snap_deals/app/home_feature/view/widgets/shimmer_product_card.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/model_view/get_all_products_cubit/get_all_products_cubit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

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

        if (state is GetAllProductsError) {
          _pagingController.error = "Something went wrong";
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
                        Text(context.tr.retry_load_product),
                        8.ph,
                        ElevatedButton(
                          onPressed: () => _pagingController.refresh(),
                          child: Text(context.tr.retry),
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
                  noItemsFoundIndicatorBuilder: (_) =>  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.search_off, size: 48, color: ColorsBox.grey),
                        8.ph,
                        Text(context.tr.no_more_data,
                            style: AppTextStyles.regular16().copyWith(color: ColorsBox.grey)),
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
