import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class ProductsHeader extends StatelessWidget {
  const ProductsHeader({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        18.pw,
        OutlinedButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
            shape: const CircleBorder(),
            fixedSize: const Size(66, 66),
          ),
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorsBox.brightBlue,
            size: 26,
          ),
        ),
        27.pw,
        Text(
          title,
          style: AppTextStyles.semiBold24()
              .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
        ),
      ],
    );
  }
}
