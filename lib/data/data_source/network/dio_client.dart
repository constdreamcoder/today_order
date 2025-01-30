import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:today_order/core/di/di_setup.dart';
import 'package:today_order/data/data_source/network/custom_interceptor.dart';
import 'package:today_order/data/data_source/remote/auth_api.dart';

import '../../../core/constant/constant.dart';

class CustomDioClient {
  static final CustomDioClient _instance = CustomDioClient._internal();

  late final Dio _dio;

  Dio get getDio => _dio;

  factory CustomDioClient() => _instance;

  CustomDioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Constant.baseUrl,
        connectTimeout: const Duration(milliseconds: 5000),
        receiveTimeout: const Duration(milliseconds: 3000),
      ),
    );

    _dio.interceptors.add(
      CustomInterceptor(
        secureStorage: getIt<FlutterSecureStorage>(),
        authApi: AuthApi(
          _dio,
        ),
      ),
    );
  }
}
