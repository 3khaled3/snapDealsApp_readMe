import 'package:flutter/material.dart';
import 'package:snap_deals/core/themes/app_colors.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    required this.currentPage,
    required this.pageLength,
  });

  final int currentPage;
  final int pageLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(
          pageLength,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: currentPage == index ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: currentPage == index
                  ? ColorsBox.brightBlue
                  : ColorsBox.greyish,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }
}
