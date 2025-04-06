import 'package:flutter/material.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_contanier.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CustomAddImage extends StatelessWidget {
  const CustomAddImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          20.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 33,
                width: 33,
                decoration: BoxDecoration(border: Border.all()),
                child: const Icon(
                  Icons.home,
                  color: ColorsBox.brightBlue,
                  size: 26,
                ),
              ),
              6.pw,
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(border: Border.all()),
                child: const Icon(
                  Icons.pedal_bike,
                  color: ColorsBox.brightBlue,
                  size: 26,
                ),
              ),
              6.pw,
              Container(
                height: 33,
                width: 33,
                decoration: BoxDecoration(border: Border.all()),
                child: const Icon(
                  Icons.home,
                  color: ColorsBox.brightBlue,
                  size: 26,
                ),
              ),
            ],
          ),
          15.ph,
          InkWell(
            onTap: () {},
            child: CustomContainer(
              width: 120,
              height: 50,
              text: context.tr.addImages,
              textStyle: AppTextStyles.medium14()
                  .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
              borderColor: ColorsBox.brightBlue,
              borderRadius: 5.0,
              onTap: () {},
            ),
          ),
          16.ph,
          Text(
            context.tr.addImageDis,
            style: AppTextStyles.regular12()
                .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
