import 'package:flutter/material.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class InfoItem extends StatelessWidget {
  final String title;
  final String value;

  const InfoItem({required this.title, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.regular14().copyWith(color: ColorsBox.grey),
          ),
          Text(
            value,
            style: AppTextStyles.bold16().copyWith(color: ColorsBox.black),
          ),
        ],
      ),
    );
  }
}
