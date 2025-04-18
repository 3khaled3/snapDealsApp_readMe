import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';

class CustomImage extends StatefulWidget {
  const CustomImage({
    super.key,
  });

  @override
  State<CustomImage> createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: SizedBox(
              height: 300,
              child: Image.asset(
                AppImageAssets.courseImage,
                fit: BoxFit.cover,
                width: double.infinity,
              )),
        ),
        SafeArea(
          child: ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                Color.fromARGB(109, 0, 0, 0),
              ),
              shape: WidgetStatePropertyAll(
                CircleBorder(),
              ),
              elevation: WidgetStatePropertyAll(0),
              overlayColor:
                  WidgetStatePropertyAll(Color.fromARGB(65, 253, 159, 27)),
            ),
            onPressed: () {
              GoRouter.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back,
              color: ColorsBox.white,
            ),
          ),
        ),
        Positioned.fill(
          bottom: 0,
          top: 260,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              DotsBuilder(
                images: ["0"],
                currentPage: currentPage,
              ),
              const Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}

class DotsBuilder extends StatelessWidget {
  const DotsBuilder(
      {super.key, required this.images, required this.currentPage});
  final List<String> images;
  final int currentPage;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        images.isEmpty ? 1 : images.length,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Container(
            decoration: BoxDecoration(
              color: currentPage == index ? ColorsBox.brightBlue : Colors.grey,
              borderRadius: BorderRadius.circular(999),
            ),
            width: currentPage == index ? 30 : 10,
            height: 10,
          ),
        ),
      ),
    );
  }
}
