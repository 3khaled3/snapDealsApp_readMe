import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:snap_deals/app/home_feature/view/widgets/Course_card.dart';
import 'package:snap_deals/app/home_feature/view/widgets/shimmer_product_card.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/app/product_feature/model_view/courses/get_all_course_cubit/get_all_courses_cubit.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';

class AllCoursesList extends StatefulWidget {
  const AllCoursesList({super.key});

  @override
  State<AllCoursesList> createState() => _AllCoursesListState();
}

class _AllCoursesListState extends State<AllCoursesList> {
  int _nextPageKey = 1;
  final PagingController<int, CourseModel> _pagingController =
      PagingController(firstPageKey: 1);

  late GetAllCoursesCubit _productCubit;

  @override
  void initState() {
    super.initState();

    _productCubit = GetAllCoursesCubit();
    _pagingController.addPageRequestListener((pageKey) {
      _productCubit.getAllCourses(limit: "20", page: pageKey.toString());
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
    return BlocBuilder<GetAllCoursesCubit, GetAllCoursesState>(
      bloc: _productCubit,
      builder: (context, state) {
        if (state is GetAllCoursesSuccess) {
          _handleFetchedProducts(state.courses);
        }

        if (state is GetAllCoursesError) {
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
