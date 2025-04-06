import 'package:flutter/material.dart';
import 'package:snap_deals/app/product_feature/view/pages/product_details/widgets/custom_button.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';

class CustomImageSlider extends StatefulWidget {
  const CustomImageSlider({super.key});

  @override
  _CustomImageSliderState createState() => _CustomImageSliderState();
}

class _CustomImageSliderState extends State<CustomImageSlider> {
  int _currentIndex = 0;
  final List<String> images = [
    AppImageAssets.profileImage,
    AppImageAssets.forgotPassImage,
    AppImageAssets.forgotPassImage,
    AppImageAssets.authImage
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: 300,
              child: PageView.builder(
                itemCount: images.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Image.asset(
                    images[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            8.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  List.generate(images.length, (index) => buildDot(index)),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.only(top: 15, left: 15),
          alignment: Alignment.topLeft,
          child: const CustomButton(),
        ),
      ],
    );
  }

  Widget buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: _currentIndex == index ? 12 : 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentIndex == index ? Colors.blue : Colors.grey,
      ),
    );
  }
}
