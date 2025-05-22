part of 'i_review_repository.dart';

class ReviewRepository implements IReviewRepository {
  @override
  Future<Either<FailureModel, Map<String, dynamic>>> addReview({required String courseId, required int rating, required String comment}) {
    return HttpHelper.handleRequest(
      (token) => HttpHelper.postData(
        linkUrl: ApiEndpoints.reviewById(courseId),
        data: {
          'rating': rating,
          'comment': comment,
        } ,
        token: token,
      ),
    );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> getReviews({required String courseId}) {
   return HttpHelper.handleRequest(
      (token) => HttpHelper.getData(
        linkUrl: ApiEndpoints.reviewsOf(courseId),
        token: token,
      ),
    );
  }
  
}