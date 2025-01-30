import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/constant/constant.dart';

class SecureStorageDao {
  final FlutterSecureStorage _storage;

  SecureStorageDao({
    required FlutterSecureStorage storage,
  }) : _storage = storage;

  Future<void> writeTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: Constant.ACCESS_TOKEN_KEY, value: accessToken);
    await _storage.write(key: Constant.REFRESH_TOKEN_KEY, value: refreshToken);
  }
}
