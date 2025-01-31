import 'package:today_order/core/model/cursor_pagination_model.dart';
import 'package:today_order/data/data_source/remote/restaurant_api.dart';
import 'package:today_order/domain/model/restaurant_detail_model.dart';
import 'package:today_order/domain/model/restaurant_model.dart';
import 'package:today_order/domain/respository/restaurant_repository.dart';

import '../../core/model/pagination_params.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RestaurantApi _restaurantApi;

  RestaurantRepositoryImpl({
    required RestaurantApi restaurantApi,
  }) : _restaurantApi = restaurantApi;

  @override
  Future<CursorPagination<RestaurantModel>> paginate({
    PaginationParams? paginationParams,
  }) async {
    return await _restaurantApi.paginate(paginationParams: paginationParams);
  }

  @override
  Future<RestaurantDetailModel> getRestaurantDetail({
    required String id,
  }) async {
    return await _restaurantApi.getDetail(id: id);
  }
}
