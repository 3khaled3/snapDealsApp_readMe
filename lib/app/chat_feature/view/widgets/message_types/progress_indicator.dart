import 'package:flutter/material.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key, required this.value});
  final String value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.,
        children: [
          Text(
            "${value} %",
            style: AppTextStyles.bold12().copyWith(color: ColorsBox.mainColor),
          ),
          8.pw,
          SizedBox(
            height: 15,
            width: 15,
            child: CircularProgressIndicator(
              backgroundColor: ColorsBox.white,
              color: ColorsBox.mainColor,
              value: value.isEmpty ? 0 : double.parse(value) / 100,
            ),
          ),
        ],
      ),
    );
  }
}
