import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/constant/constant.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage _secureStorage;

  CustomInterceptor({
    required FlutterSecureStorage secureStorage,
  }) : _secureStorage = secureStorage;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}');

    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');

      final token = await _secureStorage.read(key: Constant.ACCESS_TOKEN_KEY);

      options.headers.addAll({
        'authorization': 'Bearer $token'
      });
    }

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('[RES] [${(response.requestOptions.method)}] ${response.requestOptions.uri}');

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}');

    super.onError(err, handler);
  }
}
