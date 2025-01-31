import 'package:flutter/material.dart';
import 'package:today_order/domain/model/restaurant_detail_model.dart';

import '../../../core/constant/constant.dart';
import '../../../core/theme/app_colors.dart';

class ProductCard extends StatelessWidget {
  final RestaurantProductModel model;

  const ProductCard({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              model.imgUrl,
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
                  model.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  model.detail,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: BODY_TEXT_COLOR,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '₩${model.price}',
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
    );
  }
}
