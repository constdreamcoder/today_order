import 'dart:math';

import 'package:dio/dio.dart';
import 'package:today_order/core/utils/data_utils.dart';
import 'package:today_order/data/data_source/remote/auth_api.dart';
import 'package:today_order/data/data_source/remote/user_api.dart';
import 'package:today_order/domain/model/login_response.dart';
import 'package:today_order/domain/model/user_model.dart';

import '../../domain/respository/auth_repository.dart';
import '../data_source/local/secure_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi _authApi;
  final UserApi _userApi;
  final SecureStorageDao _secureStorageDao;

  AuthRepositoryImpl({
    required AuthApi authApi,
    required UserApi userApi,
    required SecureStorageDao secureStorageDao,
  })  : _authApi = authApi,
        _userApi = userApi,
        _secureStorageDao = secureStorageDao;

  @override
  Future<UserModelBase> login(String email, String password) async {
    try {
      final serialized = DataUtils.plainToBase64('$email:$password');
      final authorization = 'Basic $serialized';
      final response = await _authApi.login(authorization);

      await _secureStorageDao.writeTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );

      final userResponse = await _userApi.getMe();

      return userResponse;
    } catch (e) {
      print(e);
      return UserModelError(message: '로그인에 실패했습니다.');
    }
  }
}
