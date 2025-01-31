import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:today_order/core/di/di_setup.dart';
import 'package:today_order/data/data_source/local/secure_storage_dao.dart';
import 'package:today_order/data/data_source/remote/auth_api.dart';
import 'package:today_order/data/data_source/remote/product_api.dart';
import 'package:today_order/data/data_source/remote/user_api.dart';
import 'package:today_order/data/repository_impl/auth_repository_impl.dart';
import 'package:today_order/data/repository_impl/product_repository_impl.dart';
import 'package:today_order/domain/model/user_model.dart';
import 'package:today_order/domain/respository/auth_repository.dart';

final userMeProvider = NotifierProvider<UserMeNotifier, UserModelBase?>(() {
  final dio = getIt<Dio>();
  final authApi = AuthApi(dio);
  final userApi = UserApi(dio);
  final secureStorageDao = SecureStorageDao(storage: getIt<FlutterSecureStorage>());

  final authRepository = AuthRepositoryImpl(
    authApi: authApi,
    userApi: userApi,
    secureStorageDao: secureStorageDao,
  );

  return UserMeNotifier(authRepository: authRepository);
});

class UserMeNotifier extends Notifier<UserModelBase?> {
  final AuthRepository _authRepository;

  UserMeNotifier({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository {
    getMe();
  }

  @override
  UserModelBase? build() {
    return UserModelLoading();
  }

  Future<void> getMe() async {
    state = await _authRepository.getMe();
  }

  Future<UserModelBase?> login({
    required String email,
    required String password,
  }) async {
    state = UserModelLoading();

    final response = await _authRepository.login(email, password);

    state = response;
    return response;
  }

  Future<void> logout() async {
    state = null;
  }
}
