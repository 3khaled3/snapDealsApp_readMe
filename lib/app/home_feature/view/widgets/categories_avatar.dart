import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/home_feature/view/pages/courses.dart';
import 'package:snap_deals/app/home_feature/view/pages/products.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CategoriesAvatar extends StatefulWidget {
  const CategoriesAvatar({super.key});

  @override
  State<CategoriesAvatar> createState() => _CategoriesAvatarState();
}

class _CategoriesAvatarState extends State<CategoriesAvatar> {
  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      'Medical',
      'Courses',
      'Mobile',
      'More',
      'Mobile',
      'Mobile',
      'less'
    ];

    List<IconData> categoriesIcons = [
      Icons.medical_services_outlined,
      Icons.school_outlined,
      Icons.school_outlined,
      Icons.school_outlined,
      Icons.school_outlined,
      Icons.phone_iphone_outlined,
      Icons.apps_outlined
    ];
    bool isMore = false;
    return StatefulBuilder(builder: (context, setState) {
      return Wrap(
        runSpacing: 20,
        spacing: 30,
        children: List.generate(isMore ? categories.length : 4, (index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  if (categories[index] == "More" ||
                      categories[index] == "less") {
                    setState(() {
                      isMore = !isMore;
                    });
                    return;
                  }
                  if (categories[index] == "Courses") {
                    GoRouter.of(context).push(CoursesView.routeName);
                    return;
                  }
                  GoRouter.of(context).push(ProductsView.routeName);
                },
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundColor: ColorsBox.paleGrey,
                    child: Icon(
                      categoriesIcons[index],
                      color: ColorsBox.brightBlue,
                    ),
                  ),
                ),
              ),
              Text(
                categories[index],
                style: AppTextStyles.regular16(),
              ),
            ],
          );
        }),
      );
    });
  }
}
