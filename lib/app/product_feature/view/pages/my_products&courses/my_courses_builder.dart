import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:snap_deals/app/home_feature/view/widgets/course_card.dart';
import 'package:snap_deals/app/home_feature/view/widgets/shimmer_product_card.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:snap_deals/app/product_feature/model_view/courses/get_my_courses_cubit/get_my_courses_cubit.dart';
import 'package:snap_deals/app/search_feature/view/widget/empty_widget.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class MyCoursesBuilder extends StatefulWidget {
  const MyCoursesBuilder({super.key});

  @override
  State<MyCoursesBuilder> createState() => _MyCoursesBuilderState();
}

class _MyCoursesBuilderState extends State<MyCoursesBuilder> {
  int _nextPageKey = 1;
  final PagingController<int, CourseModel> _pagingController =
      PagingController(firstPageKey: 1);

  late GetMyCoursesCubit _productCubit;
   
   String userId = ProfileCubit.instance.state.profile.id;
  @override
  void initState() {
    super.initState();

    _productCubit = GetMyCoursesCubit();
    _pagingController.addPageRequestListener((pageKey) {
      _productCubit.getMyCourses(limit: "4", page: pageKey.toString(),uesrId:userId );
    });
  }

  Future<void> _handleFetchedProducts(List<CourseModel> products) async {
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
    return BlocBuilder<GetMyCoursesCubit, GetMyCoursesState>(
      bloc: _productCubit,
      builder: (context, state) {
        if (state is GetMyCoursesSuccess) {
          _handleFetchedProducts(state.courses);
        }

        if (state is GetMyCoursesError) {
         _pagingController.error = "Something went wrong";
        }

        return Column(
          children: [
            Expanded(
              child: PagedGridView<int, CourseModel>(
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
                builderDelegate: PagedChildBuilderDelegate<CourseModel>(
                  itemBuilder: (context, product, index) => Padding(
                    padding: EdgeInsets.zero,
                    child: CourseCard(course: product),
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
                      noItemsFoundIndicatorBuilder: (_) => Column(
                    children: [
                      Expanded(
                        child: EmptyWidget(
                          text: context.tr.no_course_found,
                        ),
                      ),
                    ],),
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
