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

class ReviewsSection extends StatefulWidget {
  const ReviewsSection({super.key, required this.courseId});

  final String courseId;

  @override
  State<ReviewsSection> createState() => _ReviewsSectionState();
}

class _ReviewsSectionState extends State<ReviewsSection> {
  final TextEditingController _commentController = TextEditingController();
  double _rating = 0;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReviewCubit()..getReviews(courseId: widget.courseId),
      child: BlocConsumer<ReviewCubit, ReviewState>(
        listener: (context, state) {
          if (state is AddReviewSuccess) {
            _commentController.clear();
            _rating = 0;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('context.tr.review_added_successfully')),
            );
            context.read<ReviewCubit>().getReviews(courseId: widget.courseId);
          }
          if (state is AddReviewError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('context.tr.error_adding_review')),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<ReviewCubit>();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr.make_review,
                        style: AppTextStyles.semiBold20(),
                      ),
                      const SizedBox(height: 12),
                      RatingBar.builder(
                        initialRating: _rating,
                        minRating: 1,
                        itemCount: 5,
                        allowHalfRating: false,
                        itemSize: 28,
                        unratedColor: Colors.grey.shade300,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                        onRatingUpdate: (rating) {
                          setState(() {
                            _rating = rating;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _commentController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: context.tr.review_hint,
                          hintText: context.tr.review_hint,
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            final comment = _commentController.text.trim();
                            if (_rating == 0 || comment.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('context.tr.please_fill_fields')),
                              );
                              return;
                            }
                            cubit.addReview(
                              courseId: widget.courseId,
                              rating: _rating.toInt(),
                              comment: comment,
                            );
                          },
                          icon: const Icon(Icons.send),
                          label: Text(context.tr.sendButtonLabel, style: AppTextStyles.semiBold16()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (state is GetReviewLoading)
                  const Center(child: CircularProgressIndicator()),
                if (state is GetReviewSuccess)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        16.ph,
                        Text('Reviews (${state.reviews.length})', style: AppTextStyles.semiBold20()),
                        8.ph,
                        ListView.builder(
                          itemCount: state.reviews.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final review = state.reviews[index];
                            return Column(
                              children: [
                                CustomReviewContainer(
                                  rating: review.rating!.toDouble(),
                                  name: review.user?.name ?? 'Unknown',
                                  time: review.createdAt?.toString() ?? '',
                                  comment: review.comment ?? '',
                                ),
                                10.ph,
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                if (state is GetReviewError)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Center(
                      child: Text(
                        'context.tr.no_reviews_yet',
                        style: AppTextStyles.semiBold16().copyWith(color: Colors.grey),
                      ),
                    ),
                  ),
              ],
            ),
          );
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
