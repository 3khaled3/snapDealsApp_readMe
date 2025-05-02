import 'package:flutter/material.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key, required this.value});
  final String value;

  @override
  Widget build(BuildContext context) {
    final progressValue = value.isEmpty ? 0.0 : double.parse(value) / 100;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: ColorsBox.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: ColorsBox.mainColor.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$value%",
            style: AppTextStyles.bold12().copyWith(
              color: ColorsBox.mainColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              backgroundColor: ColorsBox.white,
              valueColor: const AlwaysStoppedAnimation<Color>(ColorsBox.mainColor),
              value: progressValue,
            ),
          ),
        ],
      ),
    );
  }
}
