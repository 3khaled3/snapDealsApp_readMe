import 'package:flutter/material.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class DescriptionSection extends StatelessWidget {
  final String description;

  const DescriptionSection({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr.describtionWord,
            style: AppTextStyles.medium20().copyWith(
              fontFamily: AppTextStyles.fontFamilyLora,
              color: ColorsBox.brightBlue,
            ),
          ),
          15.ph,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              description,
              style: AppTextStyles.regular16().copyWith(color: ColorsBox.black),
            ),
          ),
        ],
      ),
    );
  }
}
