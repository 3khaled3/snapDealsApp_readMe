import 'package:flutter/material.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/about_course_section.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/contact_and_price.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/custom_image.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/lessons_section.dart';
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
  int selectedIndex = 0;

  final List<String> tabs = ['About', 'Lessons', 'Reviews'];
  List<String> lessons = [
    'Lesson 1',
    'Lesson 2',
    'Lesson 3',
    'Lesson 4',
  ];
  final List<Widget> tabContents = [
    const AboutCourseSection(),
    const LessonsSection(),
    Text('Reviews Content', style: AppTextStyles.regular16()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CustomImage(),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.sizeOf(context).height * .30, bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 28),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(55),
                    topRight: Radius.circular(55))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                30.ph,
                Text(
                  'UI/UX Basics , For Beginners',
                  style: AppTextStyles.medium20()
                      .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
                ),
                20.ph,

                /// Row with Icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person_2_outlined,
                            size: 20, color: ColorsBox.blueGrey),
                        10.pw,
                        Text('Ziad tamer',
                            style: AppTextStyles.semiBold14()
                                .copyWith(color: ColorsBox.greyish)),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.play_circle_outline,
                            size: 20, color: ColorsBox.blueGrey),
                        10.pw,
                        Text('22 lessons',
                            style: AppTextStyles.semiBold14()
                                .copyWith(color: ColorsBox.greyish)),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.military_tech_outlined,
                            size: 20, color: ColorsBox.blueGrey),
                        10.pw,
                        Text('Certificate',
                            style: AppTextStyles.semiBold14()
                                .copyWith(color: ColorsBox.greyish)),
                      ],
                    ),
                  ],
                ),
                30.ph,

                /// 🔥 Custom TabBar
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.grey, width: 0.5), // subtle bottom line
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
                                  color: ColorsBox.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: const Border(
                                      bottom: BorderSide(
                                    color: ColorsBox.black,
                                    width: 3,
                                  ))),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),

                /// Tab Content
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: SizedBox(
                    key: ValueKey(selectedIndex),
                    width: double.infinity,
                    child: tabContents[selectedIndex],
                  ),
                ),

                const Align(
                    alignment: Alignment.bottomCenter,
                    child: ContactAndPrice()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
