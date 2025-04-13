import 'package:flutter/material.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class ContactAndPrice extends StatelessWidget {
  const ContactAndPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(
              'Total Price',
              style:
                  AppTextStyles.regular16().copyWith(color: ColorsBox.blueGrey),
            ),
            Text(
              '3000 EGP ',
              style: AppTextStyles.regular16()
                  .copyWith(color: ColorsBox.brightBlue),
            ),
          ],
        ),
        const Spacer(),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: Expanded(
              child: Ink(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: 200,
                decoration: BoxDecoration(
                  color: ColorsBox.brightBlue,
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  border: Border.all(color: ColorsBox.brightBlue),
                ),
                child: Center(
                  child: Text('Chat now',
                      style: AppTextStyles.semiBold18().copyWith(
                        // fontFamily: AppTextStyles.fontFamilyLora,
                        color: ColorsBox.white,
                      )),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
