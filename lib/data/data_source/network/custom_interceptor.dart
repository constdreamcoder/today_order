import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    hide Options;
import 'package:today_order/core/routing/provider/router_provider.dart';
import 'package:today_order/data/data_source/remote/auth_api.dart';
import 'package:today_order/presentation/user/provider/user_me_provider.dart';

import '../../../core/constant/constant.dart';
import '../../../core/routing/routes.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage _secureStorage;
  final AuthApi _authApi;

  CustomInterceptor({
    required FlutterSecureStorage secureStorage,
    required AuthApi authApi,
  })  : _secureStorage = secureStorage,
        _authApi = authApi;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}');

    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');

      final token = await _secureStorage.read(key: Constant.ACCESS_TOKEN_KEY);

      options.headers.addAll({'authorization': 'Bearer $token'});
    }

    if (options.headers['refreshToken'] == 'true') {
      options.headers.remove('refreshToken');

      final token = await _secureStorage.read(key: Constant.REFRESH_TOKEN_KEY);

      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        '[RES] [${(response.requestOptions.method)}] ${response.requestOptions.uri}');

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}');

    final refreshToken =
        await _secureStorage.read(key: Constant.REFRESH_TOKEN_KEY);

    if (refreshToken == null) {
      return handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh =
        err.requestOptions.path == '/auth/token'; // 토큰 갱신 중 에러 발생 여부 확인

    if (isStatus401 && !isPathRefresh) {
      try {
        final refreshedTokenResponse = await _authApi.refreshToken();
        final accessToken = refreshedTokenResponse.accessToken;

        final options = err.requestOptions;

        options.headers.addAll({
          'authorization': 'Bearer $accessToken',
        });

        await _secureStorage.write(
          key: Constant.ACCESS_TOKEN_KEY,
          value: accessToken,
        );

        final dio = Dio(
          BaseOptions(
            baseUrl: Constant.baseUrl,
            connectTimeout: const Duration(milliseconds: 5000),
            receiveTimeout: const Duration(milliseconds: 3000),
          ),
        );

        final retriedResponse = await dio.fetch(options);

        return handler.resolve(retriedResponse);
      } on DioException catch (e, stack) {
        print(e);
        print(stack);
        await Future.wait(
          [
            _secureStorage.delete(key: Constant.REFRESH_TOKEN_KEY),
            _secureStorage.delete(key: Constant.ACCESS_TOKEN_KEY),
          ],
        );
        sharedRef?.read(userMeProvider.notifier).logout();

        return handler.reject(e);
      }
    }

    return handler.reject(err);
  }
}
