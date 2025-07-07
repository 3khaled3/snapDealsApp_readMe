import 'package:flutter/material.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CustomAddTextField extends StatelessWidget {
  const CustomAddTextField(
      {super.key,
      required this.title,
      required this.hint,
      this.isPrice,
      this.controller});
  final String title;
  final String hint;
  final bool? isPrice;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.semiBold12()
              .copyWith(fontFamily: context.tr.fontFamilyLora),
        ),
        6.ph,
        CustomTextFormField(
          hintText: hint,
          isPrice: isPrice,
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return context.tr.text_field_enter_req;
            }
            return null;
          },
        ),
      ],
    );
  }
}
