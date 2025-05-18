import 'package:flutter/material.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/app/home_feature/view/widgets/categories_avatar.dart';
import 'package:snap_deals/app/home_feature/view/widgets/home_app_bar.dart';
import 'package:snap_deals/app/home_feature/view/widgets/popular_course_builder.dart';
import 'package:snap_deals/app/home_feature/view/widgets/popular_product_builder.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class HomeViewArgs {
  //todo add any parameters you need
}

class HomeView extends StatelessWidget {
  const HomeView({this.args, super.key});
  final HomeViewArgs? args;
  static const String routeName = '/home_route';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 9, right: 9, bottom: 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          18.ph,
          HomeAppBar(ProfileCubit.instance.state.profile.name),
          18.ph,
          const Center(child: CategoriesAvatar()),
          18.ph,
          CustomTextFormField(
            hintText: context.tr.hintSearch,
            suffixIcon: Icons.search,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            child: Text(
              context.tr.popularCourse,
              style: AppTextStyles.medium20()
                  .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
            ),
          ),
          const PopularCourseBuilder(),
          // SizedBox(
          //   height: 275,
          //   child: SingleChildScrollView(
          //     scrollDirection: Axis.horizontal,
          //     child: Row(
          //       children: List.generate(
          //           10,
          //           (index) => const CourseCard(
          //                 courseName: 'Course Name ',
          //                 price: 1000,
          //                 imagePath:
          //                     "https://appmaster.io/api/_files/hRaLG2N4DVjRZJQzCpN2zJ/download/",
          //                 courseOwner: 'Ziad tamer',
          //               )),
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            child: Text(
              context.tr.popularProduct,
              style: AppTextStyles.medium20()
                  .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
            ),
          ),
          const PopularProductBuilder(),
          16.ph,
        ],
      ),
    );
  }
}
