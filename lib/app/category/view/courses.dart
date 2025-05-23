import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snap_deals/app/auth_feature/view/pages/profile_view/about_us.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/app/home_feature/view/widgets/shimmer_product_card.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/app/product_feature/model_view/courses/get_all_course_cubit/get_all_courses_cubit.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/app/home_feature/view/widgets/course_card.dart';

class CoursesViewArgs {
  final String title;

  CoursesViewArgs({required this.title});
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
    _cubit.getAllCourses(page: _page.toString(), limit: _limit.toString());
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
    _cubit.getAllCourses(page: _page.toString(), limit: _limit.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: widget.args!.title),
            16.ph,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomTextFormField(
                hintText: context.tr.hintSearch,
                suffixIcon: Icons.search,
              ),
            ),
            16.ph,
            Expanded(
              child: BlocConsumer<GetAllCoursesCubit, GetAllCoursesState>(
                bloc: _cubit,
                listener: (context, state) {
                  if (state is GetAllCoursesSuccess) {
                    setState(() {
                      _isLoading = false;
                      if (_page == 1) {
                        _courses = state.courses;
                      } else {
                        _courses.addAll(state.courses);
                      }
                      if (state.courses.length < _limit) _hasMore = false;
                    });
                  } else if (state is GetAllCoursesError) {
                    if (_page > 1) _page--;
                    _isLoading = false;
                  }
                },
                builder: (context, state) {
                  if (state is GetAllCoursesLoading && _page == 1) {
                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: 6,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                      ),
                      itemBuilder: (context, index) =>
                          const ShimmerProductCard(),
                    );
                  }

                  return Stack(
                    children: [
                      GridView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: .69,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                        ),
                        itemCount: _courses.length + (_isLoading ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < _courses.length) {
                            return CourseCard(course: _courses[index]);
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      ),
                      if (state is GetAllCoursesError && _page > 1)
                        Positioned(
                          bottom: 20,
                          right: 20,
                          child: GestureDetector(
                            onTap: _loadMoreProducts,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.refresh,
                                      color: Colors.white),
                                  8.pw,
                                  Text(
                                    context.tr.retry_load_course,
                                    style: AppTextStyles.semiBold14()
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
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
