import 'package:flutter/material.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class DescSection extends StatelessWidget {
  const DescSection({super.key, required this.description});
  final String description;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "About Course",
          style: AppTextStyles.bold18(),
          
        ),
       10.ph,
        Text(
          description,
          style: AppTextStyles.regular14().copyWith(color: ColorsBox.grey),
          
        ),
      ],
    );
  }
}
