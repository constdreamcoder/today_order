import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:today_order/domain/model/login_response.dart';
import 'package:today_order/domain/model/refreshed_token_response.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {

  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/auth/login')
  Future<LoginResponse> login(
        @Header('authorization') String authorization
      );

  @POST('/auth/token')
  @Headers({
    'refreshToken': 'true',
  })
  Future<RefreshedTokenResponse> refreshToken();
}