import 'package:hive/hive.dart';
import 'package:snap_deals/core/constants/constants.dart';

class FavoriteLocalStorage {
  static const _favoritesKey = 'ids';

  /// Access the Hive box statically
  static Box get _box => Hive.box(Constants.favorites);

  /// Get list of favorite IDs
  static List<String> getFavoriteIds() {
    final ids =
        _box.get(_favoritesKey, defaultValue: <String>[])?.cast<String>();
    return ids ?? [];
  }

  static Stream<List<String>> get favoriteIdsStreamMapped =>
      _box.watch(key: _favoritesKey).map((event) => getFavoriteIds());

  static Future<void> addFavoriteId(String id) async {
    final currentIds = getFavoriteIds();
    if (!currentIds.contains(id)) {
      await _box.put(_favoritesKey, [...currentIds, id]);
    }
  }

  static Future<void> removeFavoriteId(String id) async {
    final currentIds = getFavoriteIds();
    if (currentIds.contains(id)) {
      final updatedIds = currentIds.where((e) => e != id).toList();
      await _box.put(_favoritesKey, updatedIds);
    }
  }

  /// Clear all favorites
  static Future<void> clearFavorites() async {
    await _box.delete(_favoritesKey);
  }

  /// Check if an ID is a favorite
  static bool isFavorite(String id) {
    return getFavoriteIds().contains(id);
  }
}
