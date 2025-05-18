import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/app/home_feature/view/widgets/Course_card.dart';
import 'package:snap_deals/app/home_feature/view/widgets/product_card.dart';
import 'package:snap_deals/app/home_feature/view/widgets/shimmer_product_card.dart';
import 'package:snap_deals/app/home_feature/view/widgets/products_header.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/app/product_feature/data/models/product_model.dart';
import 'package:snap_deals/app/product_feature/model_view/courses/get_all_course_cubit/get_all_courses_cubit.dart';
import 'package:snap_deals/app/product_feature/model_view/get-products_by_category/get_products_by_category_cubit.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';

class CoursesViewArgs {
  final String title;
 

  CoursesViewArgs({ required this.title});
}

class CoursesView extends StatefulWidget {
  const CoursesView({super.key, this.args});
  final CoursesViewArgs? args;
  static const String routeName = '/courses_route';

  @override
  State<CoursesView> createState() => _CoursesViewState();
}

class _CoursesViewState extends State<CoursesView> {
  final ScrollController _scrollController = ScrollController();
  final GetAllCoursesCubit _cubit = GetAllCoursesCubit();

  int _page = 1;
  final int _limit = 10;
  bool _isLoading = false;
  bool _hasMore = true;
  List<CourseModel> _courses = [];

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
    _cubit.getAllCourses(
      page: _page.toString(),
      limit: _limit.toString(),
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
    _cubit.getAllCourses(
      page: _page.toString(),
      limit: _limit.toString(),
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
              child: BlocConsumer<GetAllCoursesCubit,
                  GetAllCoursesState>(
                bloc: _cubit,
                listener: (context, state) {
                  if (state is GetAllCoursesSuccess) {
                    _isLoading = false;
                    if (_page == 1) {
                      _courses = state.courses;
                    } else {
                      _courses.addAll(state.courses);
                    }

                    if (state.courses.length < _limit) {
                      _hasMore = false;
                    }
                  } else if (state is GetAllCoursesError) {
                    _isLoading = false;
                    _page--;
                  }
                },
                builder: (context, state) {
                  if (state is GetAllCoursesLoading && _page == 1) {
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
                  } else if (state is GetAllCoursesError &&
                      _page == 1) {
                    return Center(
                      child: Column(
                        children: [
                          const Text(" something went wrong"),
                          ElevatedButton(
                            onPressed: _loadInitialProducts,
                            child: const Text("Retry"),
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
                        itemCount: _courses.length +
                            (_isLoading || !_hasMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < _courses.length) {
                            return CourseCard(course: _courses[index]);
                          } else if (_isLoading) {
                            return const ShimmerProductCard();
                          } else if (!_hasMore) {
                            return const Center(child: Text("no more courses"));
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      if (state is GetAllCoursesError && _page > 1)
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: GestureDetector(
                            onTap: _loadMoreProducts,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              color: Colors.red,
                              child: const Text(
                                "Error loading more courses Tap to retry",
                                style: TextStyle(color: Colors.white),
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
