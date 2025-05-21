import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/app/home_feature/view/widgets/product_card.dart';
import 'package:snap_deals/app/home_feature/view/widgets/shimmer_product_card.dart';
import 'package:snap_deals/app/home_feature/view/widgets/products_header.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/model_view/get-products_by_category/get_products_by_category_cubit.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class ProductsViewArgs {
  final String title;
  final String? id;

  ProductsViewArgs({required this.id, required this.title});
}

class ProductsView extends StatefulWidget {
  const ProductsView({super.key, this.args});
  final ProductsViewArgs? args;
  static const String routeName = '/products_route';

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final ScrollController _scrollController = ScrollController();
  final GetProductsByCategoryCubit _cubit = GetProductsByCategoryCubit();

  int _page = 1;
  final int _limit = 10;
  bool _isLoading = false;
  bool _hasMore = true;
  List<ProductModel> _products = [];

  @override
  void initState() {
    super.initState();
    _loadInitialProducts();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _loadInitialProducts() {
    _cubit.getProductsByCategory(
      page: _page.toString(),
      limit: _limit.toString(),
      id: widget.args!.id!,
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading &&
        _hasMore) {
      _loadMoreProducts();
    }
  }

  void _loadMoreProducts() {
    setState(() => _isLoading = true);
    _page++;
    _cubit.getProductsByCategory(
      page: _page.toString(),
      limit: _limit.toString(),
      id: widget.args!.id!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 60, left: 11, right: 11, bottom: 20),
        child: Column(
          children: [
            ProductsHeader(title: widget.args!.title),
            17.ph,
            CustomTextFormField(
              hintText: context.tr.hintSearch,
              suffixIcon: Icons.search,
            ),
            20.ph,
            Expanded(
              child: BlocConsumer<GetProductsByCategoryCubit,
                  GetProductsByCategoryState>(
                bloc: _cubit,
                listener: (context, state) {
                  if (state is GetProductsByCategorySuccess) {
                    _isLoading = false;
                    if (_page == 1) {
                      _products = state.products;
                    } else {
                      _products.addAll(state.products);
                    }

                    if (state.products.length < _limit) {
                      _hasMore = false;
                    }
                  } else if (state is GetProductsByCategoryError) {
                    _isLoading = false;
                    _page--;
                  }
                },
                builder: (context, state) {
                  if (state is GetProductsByCategoryLoading && _page == 1) {
                    return GridView.builder(
                      itemCount: 4,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.66,
                      ),
                      itemBuilder: (context, index) =>
                          const ShimmerProductCard(),
                    );
                  } else if (state is GetProductsByCategoryError &&
                      _page == 1) {
                    return Center(
                      child: Column(
                        children: [
                          Text(
                            context.tr.error_load,
                            style: AppTextStyles.semiBold16(),
                          ),
                          ElevatedButton(
                            onPressed: _loadInitialProducts,
                            child: Text(context.tr.retry),
                          ),
                        ],
                      ),
                    );
                  }

                  return Stack(
                    children: [
                      GridView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.only(bottom: 80),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.66,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: _products.length +
                            (_isLoading || !_hasMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < _products.length) {
                            return ProductCard(product: _products[index]);
                          } else if (_isLoading) {
                            return const ShimmerProductCard();
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      if (state is GetProductsByCategoryError && _page > 1)
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: GestureDetector(
                            onTap: _loadMoreProducts,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              color: Colors.red,
                              child: Text(
                                context.tr.retry_load_product,
                                style: AppTextStyles.semiBold16().copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
