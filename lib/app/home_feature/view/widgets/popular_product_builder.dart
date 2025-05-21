import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/home_feature/view/widgets/product_card.dart';
import 'package:snap_deals/app/home_feature/view/widgets/shimmer_product_card.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/model_view/get_all_products_cubit/get_all_products_cubit.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class PopularProductBuilder extends StatefulWidget {
  const PopularProductBuilder({super.key});

  @override
  State<PopularProductBuilder> createState() => _PopularProductBuilderState();
}

class _PopularProductBuilderState extends State<PopularProductBuilder> {
  final ScrollController _scrollController = ScrollController();
  final GetAllProductsCubit getAllProductsCubit = GetAllProductsCubit();

  int page = 1;
  final int limit = 10;
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
    getAllProductsCubit.getAllProducts(
      page: page.toString(),
      limit: limit.toString(),
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
    page++;
    getAllProductsCubit.getAllProducts(
      page: page.toString(),
      limit: limit.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 275,
      child: BlocConsumer<GetAllProductsCubit, GetAllProductsState>(
        bloc: getAllProductsCubit,
        listener: (context, state) {
          if (state is GetAllProductsSuccess) {
            _isLoading = false;

            if (page == 1) {
              _products = state.products;
            } else {
              _products.addAll(state.products);
            }

            if (state.products.length < limit) {
              _hasMore = false;
            }
          } else if (state is GetAllProductsError) {
            _isLoading = false;
            page--;
          }
        },
        builder: (context, state) {
          if (state is GetAllProductsLoading && page == 1) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    List.generate(2, (index) => const ShimmerProductCard()),
              ),
            );
          } else if (state is GetAllProductsError && page == 1) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.tr.error_loading_data,
                    style: AppTextStyles.semiBold20(),
                  ),
                  ElevatedButton(
                    onPressed: _loadInitialProducts,
                    child: Text(context.tr.retry),
                  ),
                ],
              ),
            );
          } else {
            return Stack(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  child: Row(
                    children: [
                      ..._products.map(
                        (product) => ProductCard(product: product),
                      ),
                      if (_isLoading)
                        Row(
                          children: List.generate(
                              2, (index) => const ShimmerProductCard()),
                        ),
                      if (!_hasMore && _products.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Center(
                              child: Text(
                            context.tr.no_more_data,
                            style: AppTextStyles.semiBold20(),
                          )),
                        ),
                    ],
                  ),
                ),
                if (state is GetAllProductsError && page > 1)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _loadMoreProducts,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.red.withOpacity(0.7),
                        child: Text(
                          context.tr.retry_load_more,
                          style: AppTextStyles.semiBold16().copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}
