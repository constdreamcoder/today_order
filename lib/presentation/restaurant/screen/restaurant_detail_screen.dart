import 'package:flutter/material.dart';
import 'package:today_order/presentation/restaurant/component/restaurant_card.dart';

import '../../../core/layout/default_layout.dart';
import '../../product/component/product_card.dart';
import '../../rating/component/rating_card.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String id;

  const RestaurantDetailScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '불타타는 떡볶이',
      body: CustomScrollView(
        slivers: [
          renderTop(),
          renderLabel(),
          renderProducts(),
          renderRatings(),
        ],
      ),
    );
  }

  SliverToBoxAdapter renderTop() {
    return SliverToBoxAdapter(
      child: RestaurantCard(
        isFromDetail: true,
      ),
    );
  }

  SliverPadding renderLabel() {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  SliverPadding renderProducts() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: 10,
          (context, index) {
            return InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ProductCard(),
              ),
            );
          },
        ),
      ),
    );
  }

  SliverPadding renderRatings() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: 10,
          (context, index) {
            return InkWell(
              onTap: (){},
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: RatingCard(),
              ),
            );
          },
        ),
      ),
    );
  }
}
