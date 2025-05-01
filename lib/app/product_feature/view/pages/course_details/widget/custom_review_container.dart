import 'package:flutter/material.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';

class CustomReviewContainer extends StatelessWidget {
  const CustomReviewContainer(
      {super.key,
      required this.imagePath,
      required this.name,
      required this.time,
      required this.comment});
  final String imagePath;
  final String name;
  final String time;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundImage: AssetImage(imagePath),
            ),
            10.pw,
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text(
              time,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        13.ph,
        Text(
          comment,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        15.ph,
        Row(
          children: [
            Text(
              '4.5 (12000)',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  AppTextStyles.regular12().copyWith(color: ColorsBox.greyish),
            ),
            6.pw,
            ...List.generate(5, (index) {
              return Icon(
                index < 4 ? Icons.star : Icons.star_half,
                size: 16,
                color: Colors.amber,
              );
            }),
          ],
        ),
        15.ph,
      ],
    );
  }
}
