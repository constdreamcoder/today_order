import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/constant/constant.dart';

class SecureStorageDao {
  final FlutterSecureStorage _storage;

  SecureStorageDao({
    required FlutterSecureStorage storage,
  }) : _storage = storage;

  Future<void> writeValue<T>({
    required String key,
    required String value,
  }) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> getValue({
    required String key,
  }) async {
    final value = await _storage.read(key: key);
    return value;
  }
}
