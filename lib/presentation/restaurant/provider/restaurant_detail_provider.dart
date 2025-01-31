import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:today_order/core/model/cursor_pagination_model.dart';
import 'package:today_order/presentation/restaurant/provider/restaurant_provider.dart';
import 'package:collection/collection.dart';

import '../../../domain/model/restaurant_model.dart';

final restaurantDetailProvider = NotifierProvider.family<
    RestaurantDetailNotifier,
    RestaurantModel?,
    String>(() {
  return RestaurantDetailNotifier();
});

class RestaurantDetailNotifier extends FamilyNotifier<RestaurantModel?, String> {
  @override
  RestaurantModel? build(String id) {
    final state = ref.watch(restaurantProvider);

    if (state is! CursorPagination) {
      return null;
    }

    return state.data.firstWhereOrNull((e) => e.id == id);
  }
}
