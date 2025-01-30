import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:today_order/domain/model/login_response.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {

  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/auth/login')
  Future<LoginResponse> login(
        @Header('authorization') String authorization
      );

  @POST('/auth/token')
  Future<LoginResponse> refreshToken(
      @Header('authorization') String authorization
      );
}