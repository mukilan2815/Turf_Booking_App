import 'package:get_storage/get_storage.dart';

class KLocalStorage {
  late final GetStorage _storage;

  // Singleton instance
  static KLocalStorage? _instance;

  KLocalStorage._internal();

  /// Create a named constructor to obtain an instance with a specific bucket name
  factory KLocalStorage.instance() {
    _instance ??= KLocalStorage._internal();
    return _instance!;
  }


  /// Asynchronous initialization method
  static Future<void> init(String bucketName) async {
    // Very Important when you want to use Bucket's
    await GetStorage.init(bucketName);
    _instance = KLocalStorage._internal();
    _instance!._storage = GetStorage(bucketName);
  }

  /// Generic method to save data
  Future<void> saveData<K>(String key, K value) async {
    await _storage.write(key, value);
  }

  /// Generic method to read data
  K? readData<K>(String key) {
    return _storage.read<K>(key);
  }

  /// Generic method to remove data
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  /// Clear all data in storage
  Future<void> clearAll() async {
    await _storage.erase();
  }
}
