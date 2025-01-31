import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:today_order/core/model/cursor_pagination_model.dart';
import 'package:today_order/domain/model/login_response.dart';
import 'package:today_order/domain/model/product_model.dart';
import 'package:today_order/domain/model/restaurant_model.dart';

import '../../../core/model/pagination_params.dart';

part 'restaurant_api.g.dart';

@RestApi()
abstract class RestaurantApi {
  factory RestaurantApi(Dio dio, {String baseUrl}) = _RestaurantApi;

  @GET('/restaurant')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<RestaurantModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}