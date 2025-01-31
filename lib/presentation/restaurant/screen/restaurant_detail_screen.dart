import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_order/domain/model/restaurant_detail_model.dart';
import 'package:today_order/presentation/restaurant/component/restaurant_card.dart';
import 'package:today_order/presentation/restaurant/provider/restaurant_detail_provider.dart';
import 'package:today_order/presentation/restaurant/provider/restaurant_provider.dart';

import '../../../core/layout/default_layout.dart';
import '../../../domain/model/restaurant_model.dart';
import '../../product/component/product_card.dart';
import '../../rating/component/rating_card.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  final String id;

  const RestaurantDetailScreen({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<RestaurantDetailScreen> createState() =>
      _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState
    extends ConsumerState<RestaurantDetailScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantDetailProvider(widget.id));

    if (state == null) {
      return const DefaultLayout(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DefaultLayout(
      title: state.name,
      body: CustomScrollView(
        slivers: [
          renderTop(
            model: state,
          ),

          // if (state is! RestaurantDetailModel)
          if (state is RestaurantDetailModel) renderLabel(),
          if (state is RestaurantDetailModel)
            renderProducts(products: state.products),
          // renderRatings(),
        ],
      ),
    );
  }

  SliverToBoxAdapter renderTop({
    required RestaurantModel model,
  }) {
    return SliverToBoxAdapter(
      child: RestaurantCard(
        isFromDetail: true,
        model: model,
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

  SliverPadding renderProducts({
    required List<RestaurantProductModel> products,
}) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: products.length,
          (context, index) {
            final model = products[index];
            return InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ProductCard(model: model),
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
              onTap: () {},
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
