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
  bool isMore = false;

  // Original categories and icons
  final List<String> originalCategories = [
    'Medical',
    'Courses',
    'Mobile&Tablets',
    'More',
    'Drawing tools',
    'Engineering tools',
    'less'
  ];

  final List<IconData> originalIcons = [
    Icons.medical_services_outlined,
    Icons.school_outlined,
    Icons.phone_iphone_outlined,
    Icons.apps_outlined,
    Icons.school_outlined,
    Icons.engineering_outlined,
    Icons.apps_outlined
  ];

  // Mutable lists to change dynamically
  List<String> categories = [];
  List<IconData> categoriesIcons = [];

  @override
  void initState() {
    super.initState();
    // Initialize with original values
    categories = List.from(originalCategories);
    categoriesIcons = List.from(originalIcons);
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Wrap(
        runSpacing: 20,
        spacing: 15,
        children: List.generate(isMore ? categories.length : 4, (index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  if (categories[index] == "More" ||
                      categories[index] == "less") {
                    setState(() {
                      isMore = !isMore;
                      if (categories[index] == "More") {
                        // Change "More" to "Electronic" and update the icon
                        categories[index] = "Electronic";
                        categoriesIcons[index] = Icons.computer_outlined;
                      } else if (categories[index] == "less") {
                        // Restore to original categories and icons
                        categories = List.from(originalCategories);
                        categoriesIcons = List.from(originalIcons);
                      }
                    });
                    return;
                  }
                  if (categories[index] == "Courses") {
                    GoRouter.of(context).push(CoursesView.routeName,
                        extra: CoursesViewArgs(title: categories[index]));
                    return;
                  }
                  GoRouter.of(context).push(ProductsView.routeName,
                      extra: ProductsViewArgs(title: categories[index]));
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
