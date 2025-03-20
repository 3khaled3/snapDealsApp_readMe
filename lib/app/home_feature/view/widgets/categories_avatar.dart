import 'package:flutter/material.dart';
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
                  print(" ${categories[index]}");
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
    // return Container(
    //   height: 100,
    //   width: double.infinity,
    //   padding: const EdgeInsets.only(left: 35, right: 35),
    //   child: ListView.builder(
    //     scrollDirection: Axis.horizontal,
    //     itemCount: 4,
    //     itemBuilder: (context, index) {
    //       return Row(
    //         children: [
    //           Column(
    //             children: [
    //               GestureDetector(
    //                 onTap: () {},
    //                 child: SizedBox(
    //                   height: 60,
    //                   width: 60,
    //                   child: CircleAvatar(
    //                     backgroundColor: ColorsBox.paleGrey,
    //                     child: Icon(
    //                       categoriesIcons[index],
    //                       color: ColorsBox.brightBlue,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               Text(
    //                 categories[index],
    //                 style: AppTextStyles.regular16(),
    //               ),
    //             ],
    //           ),
    //           20.pw,
    //         ],
    //       );
    //     },
    //   ),
    // );
  }
}
