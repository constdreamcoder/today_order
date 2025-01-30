import 'package:dio/dio.dart';
import 'package:today_order/core/utils/data_utils.dart';
import 'package:today_order/data/data_source/remote/auth_api.dart';
import 'package:today_order/domain/model/login_response.dart';

import '../../domain/respository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi _authApi;

  AuthRepositoryImpl({
    required AuthApi authApi,
  }) : _authApi = authApi;

  @override
  Future<LoginResponse> login(String email, String password) async {
    final serialized = DataUtils.plainToBase64('$email:$password');
    final authorization = 'Basic $serialized';
    return await _authApi.login(authorization);
  }
}
