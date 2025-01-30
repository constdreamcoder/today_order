import '../model/login_response.dart';

abstract interface class AuthRepository {
  Future<LoginResponse> login(String email, String password);
}