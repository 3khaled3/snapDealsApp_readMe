import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_contanier.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CustomAddImage extends StatefulWidget {
  final Function(List<XFile>) onImagesSelected;
  final List<String> oldImages;
  final Function(int)? onOldImageRemoved;

  const CustomAddImage({
    super.key,
    required this.onImagesSelected,
    this.oldImages = const [],
    this.onOldImageRemoved,
  });

  @override
  State<CustomAddImage> createState() => _CustomAddImageState();
}

class _CustomAddImageState extends State<CustomAddImage> {
  List<XFile> selectedImages = [];

  Future<void> pickSingleImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          selectedImages = [image];
        });
        widget.onImagesSelected([image]);
      }
    } catch (e) {
      print('حدث خطأ أثناء اختيار الصورة: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasOldImages = widget.oldImages.isNotEmpty;
    final hasNewImages = selectedImages.isNotEmpty;

    // لا يوجد صور نهائيًا
    if (!hasOldImages && !hasNewImages) {
      return Container(
        height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            20.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 33,
                  width: 33,
                  decoration: BoxDecoration(border: Border.all()),
                  child: const Icon(
                    Icons.home,
                    color: ColorsBox.brightBlue,
                    size: 26,
                  ),
                ),
                6.pw,
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(border: Border.all()),
                  child: const Icon(
                    Icons.pedal_bike,
                    color: ColorsBox.brightBlue,
                    size: 26,
                  ),
                ),
                6.pw,
                Container(
                  height: 33,
                  width: 33,
                  decoration: BoxDecoration(border: Border.all()),
                  child: const Icon(
                    Icons.home,
                    color: ColorsBox.brightBlue,
                    size: 26,
                  ),
                ),
              ],
            ),
            15.ph,
            CustomContainer(
              width: 120,
              height: 50,
              text: context.tr.addImages,
              textStyle: AppTextStyles.medium14()
                  .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
              borderColor: ColorsBox.brightBlue,
              borderRadius: 5.0,
              onTap: pickSingleImage,
            ),
            16.ph,
            Text(
              context.tr.addImageDis,
              style: AppTextStyles.regular12()
                  .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    // عرض صورة قديمة واحدة فقط مع إمكانية الحذف
    if (hasOldImages) {
      return Container(
        height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                widget.oldImages.first,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 50),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () {
                  if (widget.onOldImageRemoved != null) {
                    widget.onOldImageRemoved!(0);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorsBox.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: ColorsBox.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // عرض صورة جديدة واحدة فقط
    if (hasNewImages) {
      return Container(
        height: 220,
        width: double.infinity,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.file(
                File(selectedImages[0].path),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 220,
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedImages.clear();
                    widget.onImagesSelected([]);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorsBox.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: ColorsBox.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox();
  }
}
