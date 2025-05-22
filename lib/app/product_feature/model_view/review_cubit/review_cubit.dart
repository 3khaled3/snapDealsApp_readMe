import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:snap_deals/app/product_feature/data/models/review.model.dart';
import 'package:snap_deals/app/product_feature/data/repositories/i_review_repository.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(ReviewInitial());
  final IReviewRepository _reviewRepository = ReviewRepository();
  Future<void> addReview({
    required String courseId,
    required int rating,
    required String comment,
  }) async {
    emit(AddReviewLoading());
    final result = await _reviewRepository.addReview(
      courseId: courseId,
      rating: rating,
      comment: comment,
    );
    result.fold(
      (failure) => emit(AddReviewError()),
      (response) => emit(AddReviewSuccess()),
    );
  }

  Future<void> getReviews({required String courseId}) async {
    emit(GetReviewLoading());
    final result = await _reviewRepository.getReviews(courseId: courseId);
    result.fold(
      (failure) => emit(GetReviewError()),
      (response) {
        final reviews = List<ReviewModel>.from(
          response['data'].map((x) => ReviewModel.fromJson(x)),
        );
        emit(GetReviewSuccess( reviews));
      },
    );
  }
}
