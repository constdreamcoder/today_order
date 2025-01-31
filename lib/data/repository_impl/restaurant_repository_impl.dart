import 'package:today_order/core/model/cursor_pagination_model.dart';
import 'package:today_order/data/data_source/remote/restaurant_api.dart';
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
    String? after,
  }) async {
    final paginationParams = PaginationParams(after: after);
    return await _restaurantApi.paginate(paginationParams: paginationParams);
  }
}
