import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../../data/data_source/network/dio_client.dart';

final getIt = GetIt.instance;

void diSetup() {
  getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  getIt.registerSingleton<Dio>(CustomDioClient().getDio);
}