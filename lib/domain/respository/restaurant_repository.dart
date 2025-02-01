import 'package:today_order/core/respository/base_pagination_repository_without_path.dart';
import 'package:today_order/domain/model/restaurant_detail_model.dart';
import 'package:today_order/domain/model/restaurant_model.dart';

abstract interface class RestaurantRepository
    implements IBasePaginationRepositoryWithoutPath<RestaurantModel> {
  Future<RestaurantDetailModel> getRestaurantDetail({
    required String id,
  });
}
