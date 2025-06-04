import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/app/category/view/category_detials.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/localization/generated/l10n.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CustomCategories extends StatefulWidget {
  const CustomCategories({super.key});

  @override
  State<CustomCategories> createState() => _CustomCategoriesState();
}

class _CustomCategoriesState extends State<CustomCategories> {
  bool isMore = false;

  Map<String, String> get categoriesID => {
        Tr.current.courses: '6802df0a27ad6e735473aef8',
        Tr.current.mobilesAndTablets: "6802df1b27ad6e735473aefb",
        Tr.current.drawingTools: '6802df4d27ad6e735473af01',
        Tr.current.engineeringTools: '6802df7227ad6e735473af04',
        Tr.current.electronics: '6802df4027ad6e735473aefe',
      };

  List<String> get baseCategories => [
        Tr.current.courses,
        Tr.current.mobilesAndTablets,
        Tr.current.drawingTools,
        Tr.current.engineeringTools,
      ];

  final List<IconData> baseIcons = [
    Icons.school_outlined,
    Icons.phone_iphone_outlined,
    Icons.draw_outlined,
    Icons.engineering_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    List<String> categories;
    List<IconData> categoriesIcons;

    if (isMore) {
      categories = [
        ...baseCategories,
        Tr.current.electronics,
        Tr.current.less,
      ];
      categoriesIcons = [
        ...baseIcons,
        Icons.computer_outlined,
        Icons.apps_outlined,
      ];
    } else {
      categories = [
        ...baseCategories.sublist(0, 3),
        Tr.current.more,
      ];
      categoriesIcons = [
        ...baseIcons.sublist(0, 3),
        Icons.apps_outlined,
      ];
    }

    return Wrap(
      runSpacing: 20,
      spacing: 15,
      children: List.generate(categories.length, (index) {
        return SizedBox(
          width: 80,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  final name = categories[index];

                  if (name == context.tr.more) {
                    setState(() {
                      isMore = true;
                    });
                    return;
                  } else if (name == context.tr.less) {
                    setState(() {
                      isMore = false;
                    });
                    return;
                  }

                  final id = categoriesID[name];
                  if (id != null) {
                    GoRouter.of(context).push(
                      CategoryDetails.route,
                      extra: CategoryDetailsArgs(title: name, id: id),
                    );
                  } else {
                    debugPrint("No ID found for category: $name");
                  }
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
              Hero(
                tag: 'category-from-home-${categoriesID[categories[index]]}',
                child: 0.pw,
              ),
              Text(
                categories[index],
                maxLines: categories[index] == Tr.current.electronics ? 1 : 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.regular16(),
              ),
            ],
          ),
        );
      }),
    );
  }
}
