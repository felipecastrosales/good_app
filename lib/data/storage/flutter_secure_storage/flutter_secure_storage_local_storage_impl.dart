import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:good_app/data/storage/local_secure_storage.dart';

class FlutterSecureStorageLocalStorageImpl implements LocalSecureStorage {
  const FlutterSecureStorageLocalStorageImpl({
    required FlutterSecureStorage instance,
  }) : _instance = instance;

  final FlutterSecureStorage _instance;

  @override
  Future<void> clear() => _instance.deleteAll();

  @override
  Future<bool> contains(String key) => _instance.containsKey(key: key);

  @override
  Future<String?> read(String key) => _instance.read(key: key);

  @override
  Future<void> remove(String key) => _instance.delete(key: key);

  @override
  Future<void> write(String key, String value) => _instance.write(
        key: key,
        value: value,
      );
}
