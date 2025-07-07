import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';

class EmptyWidget extends StatelessWidget {
  final String text;
  final String image;
  const EmptyWidget(
      {super.key, required this.text, this.image = AppImageAssets.emptyJson});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.white,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Spacer(flex: 2),
          Lottie.asset(image),
          const Spacer(),
          Text(
            text,
            style: AppTextStyles.medium16().copyWith(color: Colors.grey),
          ),
          const Spacer(flex: 2),
          
        ],
      ),
    );
  }
}
