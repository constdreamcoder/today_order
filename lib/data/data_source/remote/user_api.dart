import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:today_order/domain/model/user_model.dart';

part 'user_api.g.dart';

@RestApi()
abstract class UserApi {

  factory UserApi(Dio dio, {String baseUrl}) = _UserApi;

  @GET('/user/me')
  @Headers({
    'accessToken': 'true'
  })
  Future<UserModel> getMe();
}