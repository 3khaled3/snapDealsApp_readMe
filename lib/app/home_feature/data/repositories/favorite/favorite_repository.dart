part of 'i_favorite_repository.dart';
class FavoriteRepository implements IFavoriteRepository {
  @override
  Future<Either<FailureModel, Map<String, dynamic>>> addToFavorites(String id) async {
      return await HttpHelper.handleRequest(
        (token) => HttpHelper.postData(
          linkUrl: ApiEndpoints.favorites,
          data: {
            "itemId": id,
          },
          token: token,
        ),
      );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> getFavorites({required String limit, required String page}) {
    // TODO: implement getFavorites
    throw UnimplementedError();
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> removeFromFavorites(String id) {
    // TODO: implement removeFromFavorites
    throw UnimplementedError();
  }
 

  
}