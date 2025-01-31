import 'package:today_order/domain/model/restaurant_model.dart';

import '../../core/model/cursor_pagination_model.dart';

abstract interface class RestaurantRepository {
  Future<CursorPagination<RestaurantModel>> paginate();
}