import 'package:flutter/material.dart';
import 'package:today_order/presentation/restaurant/component/restaurant_card.dart';

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
          return const RestaurantCard();
        },
        itemCount: 10,
      ),
    );
  }
}
