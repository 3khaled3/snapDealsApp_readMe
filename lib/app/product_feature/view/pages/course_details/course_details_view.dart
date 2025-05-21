import 'package:flutter/material.dart';
import 'package:snap_deals/app/product_feature/data/models/course_model.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/about_course_section.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/contact_and_price.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/lessons_section.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/reviews_setion.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/widgets/custom_image_slider.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CourseDetailsViewArgs {
  final CourseModel course;

  CourseDetailsViewArgs({required this.course});
}

class CourseDetailsView extends StatefulWidget {
  const CourseDetailsView({super.key, this.args});
  final CourseDetailsViewArgs? args;

  static const String routeName = '/course_details_route';

  @override
  State<CourseDetailsView> createState() => _CourseDetailsViewState();
}

class _CourseDetailsViewState extends State<CourseDetailsView> {
  @override
  Widget build(BuildContext context) {
    final course = widget.args!.course;

    return Scaffold(
      body: Column(
        children: [
          Expanded(child: CourseDetailsBody(course: course)),
          ContactAndPrice(courseModel: course),
        ],
      ),
    );
  }
}

class CourseDetailsBody extends StatefulWidget {
  final CourseModel course;

  const CourseDetailsBody({super.key, required this.course});

  @override
  State<CourseDetailsBody> createState() => _CourseDetailsBodyState();
}

class _CourseDetailsBodyState extends State<CourseDetailsBody> {
  int selectedIndex = 0;

  final List<String> tabs = ['About', 'Lessons', 'Reviews'];

  @override
  Widget build(BuildContext context) {
    final course = widget.course;

    final List<Widget> tabContents = [
      AboutCourseSection(course: course),
      LessonsSection(lessons: course.lessons),
      ReviewsSection(reviews: course.reviews),
    ];

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          // child: CustomImage(imageUrl: course.images.first),
          child: CustomImageSlider(
           
            images: course.images,
            userId: course.instructor.id,
            productId: course.id,
            isProduct: false,
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              children: [
                30.ph,
                Text(
                  course.title,
                  style: AppTextStyles.medium20().copyWith(
                    fontFamily: context.tr.fontFamilyLora,
                  ),
                  textAlign: TextAlign.center,
                ),
                20.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _iconText(
                      icon: Icons.person_2_outlined,
                      text: course.instructor.name ?? 'N/A',
                    ),
                    _iconText(
                      icon: Icons.play_circle_outline,
                      text: '${course.lessons.length} lessons',
                    ),
                    if (course.certificate)
                      _iconText(
                        icon: Icons.military_tech_outlined,
                        text: 'Certificate',
                      ),
                  ],
                ),
                10.ph,
              ],
            ),
          ),
        ),
        MediaQuery.removePadding(
          context: context,
          removeTop: true,
          removeBottom: true,
          child: SliverAppBar(
            elevation: 0,
            titleSpacing: 0,
            floating: true,
            shadowColor: Colors.transparent,
            pinned: true,
            leadingWidth: 0,
            leading: const SizedBox.shrink(),
            backgroundColor: const Color(0xFFF9FAFB),
            title: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(tabs.length, (index) {
                    final isSelected = selectedIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          12.ph,
                          Text(
                            tabs[index],
                            style: AppTextStyles.semiBold16().copyWith(
                              color: isSelected
                                  ? ColorsBox.brightBlue
                                  : Colors.black,
                            ),
                          ),
                          8.ph,
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            height: 3,
                            width: isSelected ? 45 : 0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border(
                                bottom: BorderSide(
                                  color: isSelected
                                      ? ColorsBox.mainColor
                                      : Colors.transparent,
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              20.ph,
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Container(
                  key: ValueKey(selectedIndex),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: tabContents[selectedIndex],
                  ),
                ),
              ),
              30.ph,
            ],
          ),
        ),
      ],
    );
  }

  Widget _iconText({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, size: 20, color: ColorsBox.blueGrey),
        10.pw,
        Text(
          text,
          style: AppTextStyles.semiBold14().copyWith(color: ColorsBox.greyish),
        ),
      ],
    );
  }
}
