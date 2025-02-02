import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:today_order/domain/model/shopping_cart_item_model.dart';
import 'package:today_order/domain/model/user_model.dart';

import '../../../domain/model/patch_shopping_cart_body.dart';

part 'user_api.g.dart';

@RestApi()
abstract class UserApi {
  factory UserApi(Dio dio, {String baseUrl}) = _UserApi;

  @GET('/user/me')
  @Headers({'accessToken': 'true'})
  Future<UserModel> getMe();

  @GET('/user/me/basket')
  @Headers({'accessToken': 'true'})
  Future<List<ShoppingCartItemModel>> getShoppingCart();

  @PATCH('/user/me/basket')
  @Headers({'accessToken': 'true'})
  Future<List<ShoppingCartItemModel>> patchShoppingCart({
    @Body() required PatchShoppingCartBody body,
  });
}
