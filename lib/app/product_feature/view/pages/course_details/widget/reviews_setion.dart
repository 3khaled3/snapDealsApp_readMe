import 'package:flutter/material.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/custom_review_container.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';

class ReviewsSetion extends StatelessWidget {
  const ReviewsSetion({super.key, required this.reviews});
  final List reviews;
  @override
  Widget build(BuildContext context) {
    List<CustomReviewContainer> reviews = [
      const CustomReviewContainer(
          imagePath: AppImageAssets.profileImage,
          name: "reda ahmed",
          time: '8 month age',
          comment:
              "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer"),
      const CustomReviewContainer(
          imagePath: AppImageAssets.profileImage,
          name: "ziad tamer",
          time: '5 month age',
          comment:
              "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer"),
      const CustomReviewContainer(
          imagePath: AppImageAssets.profileImage,
          name: "khaled tarek",
          time: '12 days age',
          comment:
              "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer"),
      const CustomReviewContainer(
          imagePath: AppImageAssets.profileImage,
          name: "ahmed mohamed",
          time: '10 hours age',
          comment:
              "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer"),
      const CustomReviewContainer(
          imagePath: AppImageAssets.profileImage,
          name: "reda ahmed",
          time: '2 days age',
          comment:
              "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer"),
      const CustomReviewContainer(
          imagePath: AppImageAssets.profileImage,
          name: "reda ahmed",
          time: '2 month age',
          comment:
              "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer"),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        9.ph,
        Text('Reviews (${reviews.length})', style: AppTextStyles.semiBold20()),
        ListView.builder(
            itemCount: reviews.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  reviews[index],
                  15.ph,
                ],
              );
            }),
      ],
    );
  }
}
