import 'package:flutter/material.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_primary_button.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
                context.tr.ownerInformation,
                style: AppTextStyles.semiBold16(),
              ),
              6.ph,
              Text(
                name,
                style: AppTextStyles.medium16()
                    .copyWith(color: ColorsBox.blueGrey),
              ),
              15.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomPrimaryButton(
                      title: context.tr.callWord,
                      onTap: () {},
                    ),
                  ),
                  12.pw,
                  Expanded(
                    child: CustomPrimaryButton(
                      title: context.tr.ChatWord,
                      onTap: () {},
                      isWhite: true,
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
