import 'package:flutter/material.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CustomAddTobic extends StatefulWidget {
  const CustomAddTobic({super.key});

  @override
  State<CustomAddTobic> createState() => _CustomAddTobicState();
}

class _CustomAddTobicState extends State<CustomAddTobic> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              context.tr.tobic,
              style: AppTextStyles.semiBold12()
                  .copyWith(fontFamily: context.tr.fontFamilyLora),
            ),
            const Spacer(),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  shape: const CircleBorder(),
                  fixedSize: const Size(25, 25),
                  backgroundColor: ColorsBox.slateGrey),
              child: const Icon(
                Icons.add,
                color: ColorsBox.black,
                size: 30,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
