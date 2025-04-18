import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/about_course_section.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/contact_and_price.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/custom_image.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/lessons_section.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/reviews_setion.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CourseDetailsViewArgs {}

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
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(76, 0, 0, 0),
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      body: Column(
        children: [
          const Expanded(child: CourseDetailsBody()),
          const ContactAndPrice(),
        ],
      ),
    );
  }
}

class CourseDetailsBody extends StatefulWidget {
  const CourseDetailsBody({super.key});

  @override
  State<CourseDetailsBody> createState() => _CourseDetailsBodyState();
}

class _CourseDetailsBodyState extends State<CourseDetailsBody> {
  int selectedIndex = 0;

  final List<String> tabs = ['About', 'Lessons', 'Reviews'];
  final List<Widget> tabContents = [
    const AboutCourseSection(),
    const LessonsSection(),
    const ReviewsSetion(),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: CustomImage()),

        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(
              // top: MediaQuery.sizeOf(context).height * .28,
              bottom: 8,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 28),
            decoration: const BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(55),
                topRight: Radius.circular(55),
              ),
            ),
            child: Column(
              children: [
                30.ph,
                Text(
                  'UI/UX Basics , For Beginners',
                  style: AppTextStyles.medium20().copyWith(
                    fontFamily: AppTextStyles.fontFamilyLora,
                  ),
                  textAlign: TextAlign.center,
                ),
                20.ph,

                /// Course Info Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _iconText(
                      icon: Icons.person_2_outlined,
                      text: 'Ziad tamer',
                    ),
                    _iconText(
                      icon: Icons.play_circle_outline,
                      text: '22 lessons',
                    ),
                    _iconText(
                      icon: Icons.military_tech_outlined,
                      text: 'Certificate',
                    ),
                  ],
                ),
                30.ph,
              ],
            ),
          ),
        ),
        SliverAppBar(
          titleSpacing: 2,
          leadingWidth: 0,
          pinned: true,
          leading: const SizedBox.shrink(),
          backgroundColor: const Color(0xFFF9FAFB),
          foregroundColor: const Color(0xFFF9FAFB),
          title: Container(
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
                          color:
                              isSelected ? ColorsBox.brightBlue : Colors.black,
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
                                  ? ColorsBox.black
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

        /// Tab Bar
        SliverToBoxAdapter(
          child: Column(
            children: [
              20.ph,

              /// Tab Content wrapped in SingleChildScrollView
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
