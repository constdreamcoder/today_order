import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:today_order/domain/model/login_response.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {

  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @GET('/auth/login')
  @Headers({
    'token': 'new',
  })
  Future<LoginResponse> login();
}