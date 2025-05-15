import 'package:flutter/material.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/custom_review_container.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key, required this.reviews});
  final List reviews; // يجب أن تحتوي على بيانات حقيقية

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        9.ph,
        Text('Reviews (${reviews.length})', style: AppTextStyles.semiBold20()),
        9.ph,
        ListView.builder(
          itemCount: reviews.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final review = reviews[index];

            return Column(
              children: [
                CustomReviewContainer(
                  imagePath: review['image'] ?? AppImageAssets.profileImage,
                  name: review['name'] ?? 'Unknown',
                  time: review['time'] ?? 'N/A',
                  comment: review['comment'] ?? '',
                ),
                15.ph,
              ],
            );
          },
        ),
      ],
    );
  }
}
