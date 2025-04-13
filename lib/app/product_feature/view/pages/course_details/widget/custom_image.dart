import 'package:flutter/material.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/widgets/custom_button.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * .56,
          width: MediaQuery.sizeOf(context).width,
          padding: EdgeInsets.only(
              top: MediaQuery.sizeOf(context).height * .08,
              left: 28,
              right: 28),
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(AppImageAssets.courseImage),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
          alignment:
              context.tr.lang == "ar" ? Alignment.topRight : Alignment.topLeft,
          child: const CustomButton(),
        ),
      ],
    );
  }
}
