import 'package:flutter/material.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CategoryTabChild extends StatelessWidget {
  final String title;
  final bool isSelected;

  const CategoryTabChild({
    super.key,
    required this.title,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: isSelected ? ColorsBox.mainColor : Colors.transparent,
        border: Border.all(color: ColorsBox.mainColor, width: 2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Center(
        child: Text(
          title,
          style: AppTextStyles.bold16().copyWith(
            color: isSelected ? ColorsBox.white : ColorsBox.mainColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
