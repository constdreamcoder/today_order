import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:today_order/core/di/di_setup.dart';
import 'package:today_order/core/utils/data_utils.dart';
import 'package:today_order/data/data_source/remote/auth_api.dart';
import 'package:today_order/data/data_source/remote/user_api.dart';
import 'package:today_order/domain/model/login_response.dart';
import 'package:today_order/domain/model/user_model.dart';

import '../../core/constant/constant.dart';
import '../../domain/respository/auth_repository.dart';
import '../data_source/local/secure_storage_dao.dart';

@Singleton(as: AuthRepository)
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
        _secureStorageDao = secureStorageDao {
    // getIt<FlutterSecureStorage>().deleteAll();
  }

  @override
  Future<UserModelBase?> login(String email, String password) async {
    try {
      final serialized = DataUtils.plainToBase64('$email:$password');
      final authorization = 'Basic $serialized';
      final response = await _authApi.login(authorization);

      await _secureStorageDao.writeValue(key: Constant.ACCESS_TOKEN_KEY, value: response.accessToken);
      await _secureStorageDao.writeValue(key: Constant.REFRESH_TOKEN_KEY, value: response.refreshToken);

      final userResponse = await _userApi.getMe();

      return userResponse;
    } catch (e) {
      print(e);
      return UserModelError(message: '로그인에 실패했습니다.');
    }
  }

  @override
  Future<UserModelBase?> getMe() async {
    final refreshToken = await _secureStorageDao.getValue(key: Constant.REFRESH_TOKEN_KEY);
    final accessToken = await _secureStorageDao.getValue(key: Constant.ACCESS_TOKEN_KEY) ;

    if(refreshToken == null || accessToken == null) {
      return null;
    }

    final response = await _userApi.getMe();

    return response;
  }
}
