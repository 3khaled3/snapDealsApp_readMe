import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/home_feature/view/widgets/course_card.dart';
import 'package:snap_deals/app/home_feature/view/widgets/product_card.dart';
import 'package:snap_deals/app/home_feature/view_model/cubit/favorite_cubit.dart';
import 'package:snap_deals/app/home_feature/view_model/favorite_local_storage.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class FavoriteViewArgs {}

class FavoriteView extends StatefulWidget {
  const FavoriteView({this.args, super.key});
  final FavoriteViewArgs? args;

  static const String routeName = '/favorite_route';

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  late final FavoriteCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<FavoriteCubit>();
    _cubit.loadFavorites(); // Initial load only once
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteInitial || state is FavoriteLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FavoriteError) {
            return _buildErrorState(context, state.message);
          }

          if (state is FavoriteLoaded) {
            final allProducts = state.products;
            final allCourses = state.courses;
            final favoriteIds =
                context.read<FavoriteCubit>().favoriteIdsSaved.value;

            // Only show items that are still in the favoriteIds list
            final widgets = [
              ...allProducts
                  .where((product) => favoriteIds.contains(product.id))
                  .map((product) => ProductCard(product: product)),
              ...allCourses
                  .where((course) => favoriteIds.contains(course.id))
                  .map((course) => CourseCard(course: course)),
            ];

            if (widgets.isEmpty) {
              return  Center(
                child: Text(context.tr.no_item_in_favorite),
              );
            }

            return _buildFavoritesGrid(context, widgets);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => _cubit.loadFavorites(),
            child:  Text(context.tr.retry),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesGrid(BuildContext context, List<Widget> widgets) {
    return Column(
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.tr.favoriteView,
                style:
                    AppTextStyles.bold22().copyWith(color: ColorsBox.mainColor),
              ),
            ],
          ),
        ),
        12.ph,
        const Divider(height: 1, color: ColorsBox.greyWithOpacity20),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom:80,
            ),
            child: GridView.builder(
              itemCount: widgets.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 4,
                childAspectRatio: 0.66,
              ),
              itemBuilder: (context, index) => widgets[index],
            ),
          ),
        ),
      ],
    );
  }
}
