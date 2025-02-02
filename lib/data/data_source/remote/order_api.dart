import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:today_order/domain/model/order_model.dart';
import 'package:today_order/domain/model/post_order_body.dart';

part 'order_api.g.dart';

@RestApi()
abstract class OrderApi {
  factory OrderApi(Dio dio, {String baseUrl}) = _OrderApi;

  @POST('/order')
  @Headers({
    'accessToken': 'true',
    'Content-Type': 'application/json',
  })
  Future<OrderModel> postOrder({
    @Body() required PostOrderBody body,
  });
}
