
import 'package:dartz/dartz.dart';
import 'package:snap_deals/core/utils/api_endpoints.dart';
import 'package:snap_deals/core/utils/api_handler.dart';
part 'review_repository.dart';
abstract class IReviewRepository {
  Future<Either<FailureModel, Map<String, dynamic>>> addReview ({
    required String courseId,
    required int rating,
    required String comment,
  });
  Future<Either<FailureModel, Map<String, dynamic>>> getReviews({
    required String courseId,
    
  });
}