import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper<T> {
  // HiveHelper();
  // Private named constructor for singleton
  HiveHelper._();
  static final HiveHelper<String> _instance = HiveHelper._();
  static HiveHelper get instance => _instance;

  late Box<T> _box;

  /// Initialize Hive and open a box
  Future<void> init(String boxName) async {
    await Hive.initFlutter();

    _box = await Hive.openBox<T>(boxName);
  }

  /// Add an item to the box
  Future<void> addItem(String key, T value) async {
    await _box.put(key, value);
  }

  /// Retrieve an item by key
  T? getItem(String key) {
    return _box.get(key);
  }

  /// Retrieve all items
  Map<String, T> getAllItems() {
    return _box.toMap().cast<String, T>();
  }

  /// Remove an item by key
  Future<void> removeItem(String key) async {
    await _box.delete(key);
  }

  /// Clear all items
  Future<void> clearAllItems() async {
    await _box.clear();
  }

  /// Close the box
  Future<void> closeBox() async {
    await _box.close();
  }
}
