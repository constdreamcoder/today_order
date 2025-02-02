import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_order/domain/model/product_model.dart';
import 'package:today_order/domain/model/restaurant_detail_model.dart';
import 'package:today_order/presentation/restaurant/provider/shopping_cart_provider.dart';

import '../../../core/constant/constant.dart';
import '../../../core/theme/app_colors.dart';

class ProductCard extends ConsumerWidget {
  // final RestaurantProductModel model;
  final String imgUrl;
  final String name;
  final String detail;
  final int price;
  final String id;
  final VoidCallback? onSubtract;
  final VoidCallback? onAdd;

  ProductCard({
    super.key,
    required this.imgUrl,
    required this.name,
    required this.detail,
    required this.price,
    required this.id,
    required this.onSubtract,
    required this.onAdd,
  });

  factory ProductCard.fromRestaurantProductModel({
    required RestaurantProductModel model,
    VoidCallback? onSubtract,
    VoidCallback? onAdd,
  }) {
    return ProductCard(
      imgUrl: model.imgUrl,
      name: model.name,
      detail: model.detail,
      price: model.price,
      id: model.id,
      onSubtract: onSubtract,
      onAdd: onAdd,
    );
  }

  factory ProductCard.fromProductModel({
    required ProductModel model,
    VoidCallback? onSubtract,
    VoidCallback? onAdd,
  }) {
    return ProductCard(
      imgUrl: model.imgUrl,
      name: model.name,
      detail: model.detail,
      price: model.price,
      id: model.id,
      onSubtract: onSubtract,
      onAdd: onAdd,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shoppingCartState = ref.watch(shoppingCartProvider);

    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imgUrl,
                  width: 110,
                  height: 110,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      detail,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: BODY_TEXT_COLOR,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '₩${price}',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: PRIMAR_COLOR,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        if (onSubtract != null && onAdd != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: _Footer(
              total: (shoppingCartState
                          .firstWhere((e) => e.product.id == id)
                          .count *
                      shoppingCartState
                          .firstWhere((e) => e.product.id == id)
                          .product
                          .price)
                  .toString(),
              count: shoppingCartState
                  .firstWhere((e) => e.product.id == id)
                  .count,
              onSubtract: onSubtract!,
              onAdd: onAdd!,
            ),
          ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  final String total;
  final int count;
  final VoidCallback onSubtract;
  final VoidCallback onAdd;

  const _Footer({
    super.key,
    required this.total,
    required this.count,
    required this.onSubtract,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '총액 ₩$total',
            style: const TextStyle(
              color: PRIMAR_COLOR,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Row(
          children: [
            renderButton(
              icon: Icons.remove,
              onTap: onSubtract,
            ),
            const SizedBox(width: 8),
            Text(
              count.toString(),
              style: const TextStyle(
                color: PRIMAR_COLOR,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            renderButton(
              icon: Icons.add,
              onTap: onAdd,
            ),
          ],
        )
      ],
    );
  }

  Widget renderButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: PRIMAR_COLOR,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Icon(
          icon,
          color: PRIMAR_COLOR,
        ),
      ),
    );
  }
}
