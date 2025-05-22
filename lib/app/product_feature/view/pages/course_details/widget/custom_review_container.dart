import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomReviewContainer extends StatelessWidget {
  const CustomReviewContainer({
    super.key,
    required this.name,
    required this.time,
    required this.comment,
    required this.rating,
  });

  final String name;
  final String time;
  final String comment;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                name,
                style: AppTextStyles.semiBold16(),
              ),
              const Spacer(),
              Text(
                 DateFormat('dd MMM yyyy', 'en').format(DateTime.parse(time)),
                style: AppTextStyles.regular12().copyWith(color: ColorsBox.grey),
              ),
            ],
          ),
          10.ph,
          Text(
            comment,
            style: AppTextStyles.regular14(),
          ),
          12.ph,
          Row(
            children: [
              RatingBarIndicator(
                rating: rating,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 20.0,
                unratedColor: Colors.grey.shade300,
                direction: Axis.horizontal,
              ),
              8.pw,
              Text(
                rating.toStringAsFixed(1),
                style: AppTextStyles.regular12().copyWith(color: Colors.grey),
              )
            ],
          )
        ],
      ),
    );
  }
}
