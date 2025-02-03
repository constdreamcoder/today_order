import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_order/core/di/di_setup.dart';
import 'package:today_order/domain/model/user_model.dart';
import 'package:today_order/domain/respository/auth_repository.dart';

final userMeProvider = NotifierProvider<UserMeNotifier, UserModelBase?>(() {
  return UserMeNotifier(authRepository: getIt<AuthRepository>());
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
