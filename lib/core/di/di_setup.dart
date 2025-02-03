import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:retrofit/http.dart';
import 'package:today_order/data/data_source/local/secure_storage_dao.dart';
import 'package:today_order/data/repository_impl/auth_repository_impl.dart';
import 'package:today_order/data/repository_impl/restaurant_rating_repository_impl.dart';
import 'package:today_order/data/repository_impl/restaurant_repository_impl.dart';
import 'package:today_order/domain/respository/auth_repository.dart';
import 'package:today_order/domain/respository/restaurant_rating_repository.dart';

import '../../data/data_source/network/dio_client.dart';
import '../../data/data_source/remote/auth_api.dart';
import '../../data/data_source/remote/order_api.dart';
import '../../data/data_source/remote/restaurant_api.dart';
import '../../data/data_source/remote/user_api.dart';
import '../../data/repository_impl/order_repository_impl.dart';
import '../../data/repository_impl/shopping_cart_respository_impl.dart';
import '../../domain/respository/order_repository.dart';
import '../../domain/respository/restaurant_repository.dart';
import '../../domain/respository/shopping_cart_repository.dart';

final getIt = GetIt.instance;

void diSetup() {
  getIt.registerSingleton<FlutterSecureStorage>(
    const FlutterSecureStorage(),
  );
  getIt.registerSingleton<Dio>(
    CustomDioClient().getDio,
  );

  // local data source
  getIt.registerSingleton(
    SecureStorageDao(storage: getIt()),
  );

  // remote data source
  getIt.registerSingleton<RestaurantApi>(
    RestaurantApi(
      getIt(),
    ),
  );
  getIt.registerSingleton<UserApi>(
    UserApi(
      getIt(),
    ),
  );
  getIt.registerSingleton<OrderApi>(
    OrderApi(
      getIt(),
    ),
  );
  getIt.registerSingleton<AuthApi>(
    AuthApi(
      getIt(),
    ),
  );

  // repository
  getIt.registerSingleton<RestaurantRepository>(
    RestaurantRepositoryImpl(
      restaurantApi: getIt(),
    ),
  );
  getIt.registerSingleton<RestaurantRatingRepository>(
    RestaurantRatingRepositoryImpl(
      restaurantApi: getIt(),
    ),
  );
  getIt.registerSingleton<ShoppingCartRepository>(
    ShoppingCartRepositoryImpl(
      userApi: getIt(),
    ),
  );
  getIt.registerSingleton<OrderRepository>(
    OrderRepositoryImpl(
      orderApi: getIt(),
    ),
  );
  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      authApi: getIt(),
      userApi: getIt(),
      secureStorageDao: getIt(),
    ),
  );
}
