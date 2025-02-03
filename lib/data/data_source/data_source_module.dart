
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:today_order/core/di/di_setup.dart';
import 'package:today_order/data/data_source/local/secure_storage_dao.dart';
import 'package:today_order/data/data_source/remote/auth_api.dart';
import 'package:today_order/data/data_source/remote/order_api.dart';
import 'package:today_order/data/data_source/remote/product_api.dart';
import 'package:today_order/data/data_source/remote/restaurant_api.dart';
import 'package:today_order/data/data_source/remote/user_api.dart';

import 'network/dio_client.dart';

@module
abstract class DataSourceModule {

  @singleton
  Dio get _dio => CustomDioClient().getDio;

  @preResolve // 비동기 초기화 지원
  Future<FlutterSecureStorage> get secureStorage => Future.value(const FlutterSecureStorage());

  @singleton
  AuthApi get authApi => AuthApi(_dio);

  @singleton
  OrderApi get orderApi => OrderApi(_dio);

  @singleton
  ProductApi get productApi => ProductApi(_dio);

  @singleton
  RestaurantApi get restaurantApi => RestaurantApi(_dio);

  @singleton
  UserApi get userApi => UserApi(_dio);

  @singleton
  SecureStorageDao get secureStorageDao => SecureStorageDao(storage: getIt<FlutterSecureStorage>());
}