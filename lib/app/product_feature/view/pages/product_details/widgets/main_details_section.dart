import 'package:flutter/material.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class MainDetailsSection extends StatelessWidget {
  const MainDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'EGP 53.000',
              style: AppTextStyles.medium20().copyWith(
                fontFamily: AppTextStyles.fontFamilyLora,
                color: ColorsBox.brightBlue,
              ),
            ),
            const Spacer(),
            Text(
              '${context.tr.brandHint} : Samsung',
              style: AppTextStyles.medium20().copyWith(
                fontFamily: AppTextStyles.fontFamilyLora,
                color: ColorsBox.brightBlue,
              ),
            ),
          ],
        ),
        15.ph,
        Text(
          'Samsung Galaxy S24 Ultra',
          style: AppTextStyles.medium16(),
        ),
        15.ph,
        Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 20,
            ),
            Text(
              'Zagazig , sharqia',
              style: AppTextStyles.medium16(),
            ),
            const Spacer(),
            Text(
              '20/11/2024',
              style: AppTextStyles.medium16(),
            ),
          ],
        ),
      ],
    );
  }
}
