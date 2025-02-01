import 'package:today_order/core/model/cursor_pagination_model.dart';

import 'package:today_order/core/model/pagination_params.dart';

import 'package:today_order/domain/model/rating_model.dart';

import '../../domain/respository/restaurant_rating_repository.dart';
import '../data_source/remote/restaurant_api.dart';

class RestaurantRatingRepositoryImpl implements RestaurantRatingRepository {
  final RestaurantApi _restaurantApi;

  RestaurantRatingRepositoryImpl({
    required RestaurantApi restaurantApi,
  }) : _restaurantApi = restaurantApi;

  @override
  Future<CursorPagination<RatingModel>> paginate({
    required String id,
    PaginationParams? paginationParams,
  }) async {
    return await _restaurantApi.paginateRatings(
      id: id,
      paginationParams: paginationParams,
    );
  }
}
