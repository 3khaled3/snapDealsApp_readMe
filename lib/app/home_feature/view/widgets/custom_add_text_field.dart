import 'package:flutter/material.dart';
import 'package:snap_deals/app/auth_feature/view/widgets/custom_text_field.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CustomAddTextField extends StatelessWidget {
  const CustomAddTextField(
      {super.key, required this.title, required this.hint, this.isPrice});
  final String title;
  final String hint;
  final bool? isPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.semiBold12()
              .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
        ),
        6.ph,
        CustomTextFormField(hintText: hint, isPrice: isPrice),
      ],
    );
  }
}
