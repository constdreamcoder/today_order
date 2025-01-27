import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:today_order/core/routing/router.dart';
import 'package:today_order/presentation/restaurant/component/restaurant_card.dart';

import '../../../core/routing/route_paths.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: const RestaurantCard(),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
