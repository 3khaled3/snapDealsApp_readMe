import 'package:flutter/material.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class DetailsSection extends StatelessWidget {
  final Map<String, String> details;

  const DetailsSection({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            context.tr.details,
            style: AppTextStyles.medium20().copyWith(
              fontFamily: AppTextStyles.fontFamilyLora,
              color: ColorsBox.brightBlue,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: details.length,
          itemBuilder: (context, index) {
            final key = details.keys.elementAt(index);
            final value = details[key];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: RichText(
                text: TextSpan(
                  text: key,
                  style: AppTextStyles.medium16()
                      .copyWith(color: ColorsBox.brightBlue),
                  children: [
                    TextSpan(
                        text: ' : $value',
                        style: AppTextStyles.regular16()
                            .copyWith(color: ColorsBox.black)),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
