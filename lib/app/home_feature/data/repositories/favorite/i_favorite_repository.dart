import 'package:dartz/dartz.dart';
import 'package:snap_deals/core/utils/api_endpoints.dart';
import 'package:snap_deals/core/utils/api_handler.dart';

part 'favorite_repository.dart';
abstract class IFavoriteRepository {
  Future<Either<FailureModel, Map<String, dynamic>>> getFavorites();
  Future<Either<FailureModel, Map<String, dynamic>>> addToFavorites(String id);
  Future<Either<FailureModel, Map<String, dynamic>>> removeFromFavorites(String id);
}