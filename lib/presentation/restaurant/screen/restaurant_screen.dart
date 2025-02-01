import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:today_order/core/component/custom_button.dart';
import 'package:today_order/core/model/cursor_pagination_model.dart';
import 'package:today_order/core/routing/routes.dart';
import 'package:today_order/core/view/cursor_pagination_loading_circle.dart';
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
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(restaurantProvider.notifier).paginate();
    });

    controller.addListener(listener);
  }

  void listener() {
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      ref.read(restaurantProvider.notifier).paginate(fetchMore: true);
    }
  }

  @override
  void dispose() {
    controller.removeListener(listener);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantProvider);
    // print(state);

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
            child: const Text('다시시도'),
          ),
        ],
      );
    }

    final cp = state as CursorPagination<RestaurantModel>;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        controller: controller,
        itemCount: cp.data.length + 1,
        itemBuilder: (context, index) {
          if (index == state.data.length) {
            return CursorPaginationLoadingCircle(
              state: cp,
            );
          }

          final restaurant = cp.data[index];

          return GestureDetector(
            onTap: () {
              context.push(
                '${RoutePaths.restaurant}/${restaurant.id}',
              );
            },
            child: RestaurantCard(model: restaurant),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
      ),
    );
  }
}
