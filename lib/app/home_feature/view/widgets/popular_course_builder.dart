import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/home_feature/view/widgets/Course_card.dart';
import 'package:snap_deals/app/home_feature/view/widgets/shimmer_product_card.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/app/product_feature/model_view/courses/get_all_course_cubit/get_all_courses_cubit.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class PopularCourseBuilder extends StatefulWidget {
  const PopularCourseBuilder({super.key});

  @override
  State<PopularCourseBuilder> createState() => _PopularCourseBuilderState();
}

class _PopularCourseBuilderState extends State<PopularCourseBuilder> {
  final ScrollController _scrollController = ScrollController();
  final GetAllCoursesCubit getAllCoursesCubit = GetAllCoursesCubit();

  int page = 1;
  final int limit = 10;
  bool _isLoading = false;
  bool _hasMore = true;
  List<CourseModel> _Courses = [];

  @override
  void initState() {
    super.initState();
    _loadInitialCourses();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _loadInitialCourses() {
    getAllCoursesCubit.getAllCourses(
      page: page.toString(),
      limit: limit.toString(),
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading &&
        _hasMore) {
      _loadMoreCourses();
    }
  }

  void _loadMoreCourses() {
    setState(() => _isLoading = true);
    page++;
    getAllCoursesCubit.getAllCourses(
      page: page.toString(),
      limit: limit.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 276,
      child: BlocConsumer<GetAllCoursesCubit, GetAllCoursesState>(
        bloc: getAllCoursesCubit,
        listener: (context, state) {
          if (state is GetAllCoursesSuccess) {
            _isLoading = false;

            if (page == 1) {
              _Courses = state.courses;
            } else {
              _Courses.addAll(state.courses);
            }

            if (state.courses.length < limit) {
              _hasMore = false;
            }
          } else if (state is GetAllCoursesError) {
            _isLoading = false;
            page--;
          }
        },
        builder: (context, state) {
          if (state is GetAllCoursesLoading && page == 1) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    List.generate(2, (index) => const ShimmerProductCard()),
              ),
            );
          } else if (state is GetAllCoursesError && page == 1) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.tr.error_loading_data,
                    style: AppTextStyles.semiBold20(),
                  ),
                  ElevatedButton(
                    onPressed: _loadInitialCourses,
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
                      ..._Courses.map(
                        (course) => CourseCard(course: course),
                      ),
                      if (_isLoading)
                        Row(
                          children: List.generate(
                              2, (index) => const ShimmerProductCard()),
                        ),
                      if (!_hasMore && _Courses.isNotEmpty)
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
                if (state is GetAllCoursesError && page > 1)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _loadMoreCourses,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: ColorsBox.red.withOpacity(0.7),
                        child: Text(
                          context.tr.retry_load_more,
                          style: AppTextStyles.semiBold16().copyWith(
                            color: ColorsBox.white,
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
