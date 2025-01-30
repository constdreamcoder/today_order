import '../model/user_model.dart';

abstract interface class AuthRepository {
  Future<UserModelBase> login(String email, String password);
  Future<UserModelBase> getMe();
}