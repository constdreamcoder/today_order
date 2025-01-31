import 'package:today_order/domain/model/restaurant_detail_model.dart';
import 'package:today_order/domain/model/restaurant_model.dart';

import '../../core/respository/base_pagination_repository.dart';

abstract interface class RestaurantRepository
    implements IBasePaginationRepository<RestaurantModel> {
  Future<RestaurantDetailModel> getDetail({
    required String rid,
  });
}
