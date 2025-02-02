import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_order/core/theme/app_colors.dart';
import 'package:today_order/core/view/cursor_pagination_loading_circle.dart';
import 'package:today_order/domain/model/rating_model.dart';
import 'package:today_order/domain/model/restaurant_detail_model.dart';
import 'package:today_order/presentation/restaurant/component/restaurant_card.dart';
import 'package:today_order/presentation/restaurant/provider/restaurant_detail_provider.dart';
import 'package:today_order/presentation/restaurant/provider/restaurant_provider.dart';
import 'package:badges/badges.dart' as badges;

import '../../../core/layout/default_layout.dart';
import '../../../core/model/cursor_pagination_model.dart';
import '../../../domain/model/restaurant_model.dart';
import '../../product/component/product_card.dart';
import '../../rating/component/rating_card.dart';
import '../provider/restaurant_rating_provider.dart';

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
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref
          .read(restaurantRatingProvider.notifier)
          .paginate(id: widget.id, forceRefetch: true);
    });

    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);

    controller.addListener(listener);
  }

  void listener() {
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      ref.read(restaurantRatingProvider.notifier).paginate(
            id: widget.id,
            fetchMore: true,
          );
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
    final state = ref.watch(restaurantDetailProvider(widget.id));
    final ratingsState = ref.watch(restaurantRatingProvider);

    if (state == null) {
      return const DefaultLayout(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DefaultLayout(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        onPressed: () {},
        backgroundColor: PRIMAR_COLOR,
        child: badges.Badge(
          showBadge: true,
          badgeContent: Text(
            '12',
            style: TextStyle(
              color: PRIMAR_COLOR,
              fontSize: 10,
            ),
          ),
          badgeStyle: badges.BadgeStyle(
            badgeColor: Colors.white,
          ),
          child: Icon(
            Icons.shopping_basket_outlined,
            color: Colors.white,
          ),
        ),
      ),
      title: state.name,
      body: CustomScrollView(
        controller: controller,
        slivers: [
          renderTop(
            model: state,
          ),
          // if (state is! RestaurantDetailModel)
          if (state is RestaurantDetailModel) renderLabel(),
          if (state is RestaurantDetailModel)
            renderProducts(products: state.products),
          if (ratingsState is CursorPagination<RatingModel>)
            renderRatings(
              models: ratingsState.data,
              ratingState: ratingsState,
            ),
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

  SliverPadding renderRatings({
    required List<RatingModel> models,
    required CursorPagination ratingState,
  }) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: models.length + 1,
          (context, index) {
            if (index == models.length) {
              return CursorPaginationLoadingCircle(state: ratingState);
            }

            final model = models[index];

            return InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: RatingCard(
                  model: model,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
