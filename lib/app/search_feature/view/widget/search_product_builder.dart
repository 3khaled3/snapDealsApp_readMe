import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/home_feature/view/widgets/product_card.dart';
import 'package:snap_deals/app/home_feature/view/widgets/shimmer_product_card.dart';
import 'package:snap_deals/app/search_feature/view/widget/empty_widget.dart';
import 'package:snap_deals/app/search_feature/view_model/cubit/search_cubit.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class SearchProductBuilder extends StatelessWidget {
  const SearchProductBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchInitial) {
          return Center(
            child: Text(context.tr.type_to_search),
          );
        }
        if (state is SearchLoading) {
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.66,
            ),
            itemBuilder: (_, __) => const ShimmerProductCard(),
          );
        }

        if (state is SearchSuccess) {
          final products = state.products;
          if (products.isEmpty) {
            return Center(
              child: Column(
                children: [
                  Expanded(
                    child: EmptyWidget(
                      text: context.tr.no_product_found,
                    ),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.66,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(product: product);
            },
          );
        }

        if (state is SearchError) {
          return Center(child: Text(context.tr.error_load));
        }

        return const SizedBox.shrink();
      },
    );
  }
}
