import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:snap_deals/app/product_feature/data/models/review.model.dart';
import 'package:snap_deals/app/product_feature/model_view/review_cubit/review_cubit.dart';
import 'package:snap_deals/app/product_feature/view/pages/course_details/widget/custom_review_container.dart';
import 'package:snap_deals/core/extensions/context_extension.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';
import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
import 'package:snap_deals/core/utils/assets_manager.dart';

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key, required this.courseId});

  final String courseId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReviewCubit()..getReviews(courseId: courseId),
      child: BlocBuilder<ReviewCubit, ReviewState>(
        builder: (context, state) {
          if (state is GetReviewLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetReviewError) {
            return Center(child: Text('حدث خطأ أثناء تحميل التقييمات'));
          }

          if (state is GetReviewSuccess) {
            final reviews = state.reviews;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showRatingDialog(context, courseId: courseId);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsBox.brightBlue,
                    foregroundColor: ColorsBox.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    elevation: 2,
                  ),
                  child: Text(
                    context.tr.make_review,
                    style: AppTextStyles.semiBold16().copyWith(
                      color: ColorsBox.white,
                    ),
                  ),
                ),
                9.ph,
                Text('Reviews (${reviews.length})',
                    style: AppTextStyles.semiBold20()),
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
                          imagePath: AppImageAssets.profileImage,
                          name: review.user?.name ?? 'Unknown',
                          time: review.createdAt?.toString() ?? 'N/A',
                          comment: review.comment ?? '',
                        ),
                        15.ph,
                      ],
                    );
                  },
                ),
              ],
            );
          }

          return const SizedBox.shrink(); // في حال لم يكن هناك state متوقع
        },
      ),
    );
  }
}

void showRatingDialog(BuildContext context, {required String courseId}) {
  double rating = 0;
  final TextEditingController commentController = TextEditingController();

  // استدعاء ReviewCubit من الـcontext بدلاً من إنشاء نسخة جديدة
  final reviewCubit = BlocProvider.of<ReviewCubit>(context);

  showDialog(
    context: context,
    builder: (context) {
      return BlocProvider.value(
        value: reviewCubit,
        child: AlertDialog(
          backgroundColor: ColorsBox.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(context.tr.review, style: AppTextStyles.semiBold20()),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemSize: 36,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (value) {
                    rating = value;
                  },
                ),
                16.ph,
                TextField(
                  controller: commentController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: context.tr.review_hint,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                context.tr.cancel,
                style: AppTextStyles.semiBold16()
                    .copyWith(color: ColorsBox.brightRed),
              ),
            ),
            BlocBuilder<ReviewCubit, ReviewState>(
              builder: (context, state) {
                final isLoading = state is AddReviewLoading;

                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsBox.brightBlue,
                    foregroundColor: ColorsBox.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    elevation: 2,
                  ),
                  onPressed: isLoading
                      ? null
                      : () async {
                          final comment = commentController.text.trim();

                          if (rating == 0 || comment.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('يرجى إدخال تقييم وتعليق')),
                            );
                            return;
                          }

                         await reviewCubit.addReview(
                            courseId: courseId,
                            rating: rating.toInt(),
                            comment: comment,
                          );
                           Navigator.pop(context);
                        },
                  child: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : Text(
                          context.tr.sendButtonLabel,
                          style: AppTextStyles.semiBold16(),
                        ),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}
