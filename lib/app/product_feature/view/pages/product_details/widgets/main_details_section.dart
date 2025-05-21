import 'package:flutter/material.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class MainDetailsSection extends StatelessWidget {
  final String price;
  // final String brand;
  final String title;
  final String location;
  final String date;

  const MainDetailsSection({
    super.key,
    required this.price,
    // required this.brand,
    required this.title,
    required this.location,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                price,
                style: AppTextStyles.medium20().copyWith(
                  fontFamily: context.tr.fontFamilyLora,
                  color: ColorsBox.brightBlue,
                ),
              ),
              // const Spacer(),
              // Text(
              //   '${context.tr.brandHint} : $brand',
              //   style: AppTextStyles.medium20().copyWith(
              //     fontFamily: context.tr.fontFamilyLora,
              //     color: ColorsBox.brightBlue,
              //   ),
              // ),
            ],
          ),
          15.ph,
          Text(
            title,
            style: AppTextStyles.medium16(),
          ),
          15.ph,
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 20,
              ),
              Expanded(
                child: Text(
                  location,
                  style: AppTextStyles.medium16(),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              Text(
                date,
                style: AppTextStyles.medium16(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
