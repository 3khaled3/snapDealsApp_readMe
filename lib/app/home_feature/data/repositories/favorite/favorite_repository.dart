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
  Future<Either<FailureModel, Map<String, dynamic>>> getFavorites() {
    return HttpHelper.handleRequest(
      (token) => HttpHelper.getData(
        linkUrl: ApiEndpoints.favorites,
        token: token,
      ),
    );
  }

  @override
  Future<Either<FailureModel, Map<String, dynamic>>> removeFromFavorites(String id) {
   return HttpHelper.handleRequest(
        (token) => HttpHelper.deleteData(
          linkUrl: ApiEndpoints.favoriteById(id),
          data:null,
          token: token,
        ),
      );
  }
 

  
}