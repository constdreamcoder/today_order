import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:today_order/core/component/custom_button.dart';
import 'package:today_order/core/model/cursor_pagination_model.dart';
import 'package:today_order/core/routing/routes.dart';
import 'package:today_order/domain/model/restaurant_model.dart';
import 'package:today_order/presentation/restaurant/component/restaurant_card.dart';
import 'package:today_order/presentation/restaurant/provider/restaurant_provider.dart';

import '../../../core/routing/route_paths.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({super.key});

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(restaurantProvider.notifier).paginate();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantProvider);

    if (state is CursorPaginationLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is CursorPaginationError) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            state.message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          CustomButton(
            onPressed: () {
              ref.read(restaurantProvider.notifier).paginate(
                forceRefetch: true,
              );
            },
            child: const Text(
              '다시시도'
            ),
          ),
        ],
      );
    }

    final cp = state as CursorPagination<RestaurantModel>;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
        separatorBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.push(
                '${RoutePaths.restaurant}/12341234',
              );
            },
            child: RestaurantCard(model: state.data[index]),
          );
        },
        itemCount: state.data.length,
      ),
    );
  }
}
