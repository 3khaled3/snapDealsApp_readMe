part of 'review_cubit.dart';

sealed class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object> get props => [];
}

final class ReviewInitial extends ReviewState {}
final class ReviewLoading extends ReviewState {}
final class ReviewSuccess extends ReviewState {}
final class ReviewError extends ReviewState {}

final class AddReviewLoading extends ReviewState {}
final class AddReviewSuccess extends ReviewState {}
final class AddReviewError extends ReviewState {}

final class GetReviewLoading extends ReviewState {}
final class GetReviewSuccess extends ReviewState {
  final List<ReviewModel> reviews;
  const GetReviewSuccess(this.reviews);
}
final class GetReviewError extends ReviewState {}


