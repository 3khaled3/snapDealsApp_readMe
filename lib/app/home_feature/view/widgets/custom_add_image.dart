import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snap_deals/app/home_feature/view/widgets/custom_contanier.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CustomAddImage extends StatefulWidget {
  final Function(List<XFile>) onImagesSelected;

  const CustomAddImage({super.key, required this.onImagesSelected});

  @override
  State<CustomAddImage> createState() => _CustomAddImageState();
}

class _CustomAddImageState extends State<CustomAddImage> {
  List<XFile> selectedImages = [];

  Future<void> pickMultipleImages() async {
    final ImagePicker picker = ImagePicker();
    try {
      final List<XFile> images = await picker.pickMultiImage();
      if (images.isNotEmpty) {
        setState(() {
          selectedImages = images;
        });
        widget.onImagesSelected(images); // أرسل الصور للأب
      } else {
        print('لم يتم اختيار أي صورة');
      }
    } catch (e) {
      print('حدث خطأ أثناء اختيار الصور: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          // 20.ph,
          // Wrap(
          //   spacing: 6,
          //   runSpacing: 6,
          //   children: selectedImages
          //       .map((image) => Image.network(
          //             image.path,
          //             width: 50,
          //             height: 50,
          //             fit: BoxFit.cover,
          //           ))
          //       .toList(),
          // ),
          15.ph,
          CustomContainer(
            width: 120,
            height: 50,
            text: context.tr.addImages,
            textStyle: AppTextStyles.medium14()
                .copyWith(fontFamily: AppTextStyles.fontFamilyLora),
            borderColor: ColorsBox.brightBlue,
            borderRadius: 5.0,
            onTap: pickMultipleImages,
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
}
