// Reusable Custom Widget
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final TextStyle? textStyle;
  final Color borderColor;
  final double borderRadius;
  final VoidCallback onTap;
  final Color? backgroundColor;

  const CustomContainer({
    super.key,
    required this.width,
    required this.height,
    required this.text,
    this.textStyle,
    this.borderColor = Colors.black,
    this.borderRadius = 10.0,
    required this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(borderRadius),
          color: backgroundColor,
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle ?? const TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }
}

// Usage Example
// CustomContainer(
//   width: 55,
//   height: 30,
//   text: context.tr.newWord,
//   textStyle: AppTextStyles.regular12(),
//   borderColor: Colors.black,
//   borderRadius: 10.0,
// )
// CustomContainer(
//   width: 120,
//   height: 50,
//   text: context.tr.addImages,
//   textStyle: AppTextStyles.medium14().copyWith(fontFamily: context.tr.fontFamilyLora),
//   borderColor: ColorsBox.brightBlue,
//   borderRadius: 5.0,
// )
