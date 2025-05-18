import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/home_feature/view/widgets/Course_card.dart';
import 'package:snap_deals/app/home_feature/view/widgets/product_card.dart';
import 'package:snap_deals/app/home_feature/view_model/favorite_cubit/get_favorite/get_favorite_cubit.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class FavoriteViewArgs {}

class FavoriteView extends StatelessWidget {
  const FavoriteView({this.args, super.key});
  final FavoriteViewArgs? args;

  static const String routeName = '/favorite_route';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetFavoriteCubit()..getFavorites(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<GetFavoriteCubit, GetFavoriteState>(
            builder: (context, state) {
              if (state is GetFavoriteLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetFavoriteError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("حدث خطأ أثناء تحميل المفضلة"),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<GetFavoriteCubit>().getFavorites(),
                        child: const Text("إعادة المحاولة"),
                      ),
                    ],
                  ),
                );
              } else if (state is GetFavoriteSuccess) {
                final products = state.products;
                final courses = state.courses;

                if (products.isEmpty && courses.isEmpty) {
                  return const Center(child: Text("لا توجد عناصر مفضلة حتى الآن"));
                }
               final List<Widget> productWidgets =
      products.map((item) => ProductCard(product: item)).toList();

  final List<Widget> courseWidgets =
      courses.map((item) => CourseCard(course: item)).toList();

  final List<Widget> allWidgets = [...productWidgets, ...courseWidgets];

                return Column(
                  children: [
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        context.tr.favoriteView,
                        style: AppTextStyles.semiBold20().copyWith(
                          fontFamily: AppTextStyles.fontFamilyLora,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(
                      color: ColorsBox.greyishTwo,
                      height: 1,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: GridView.builder(
                          itemCount: allWidgets.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 0.66,
                          ),
                          itemBuilder:(context, index) => allWidgets[index],

                        ),
                      ),
                    ),
                  ],
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
