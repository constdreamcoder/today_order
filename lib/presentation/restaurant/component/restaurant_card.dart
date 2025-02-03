import 'package:flutter/material.dart';
import 'package:today_order/domain/model/restaurant_detail_model.dart';

import '../../../core/constant/constant.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/model/restaurant_model.dart';

class RestaurantCard extends StatelessWidget {
  final bool isFromDetail;
  final RestaurantModel? model;
  final String? detail;
  final String? heroKey;

  const RestaurantCard({
    super.key,
    this.isFromDetail = false,
    this.model,
    this.detail,
    this.heroKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (heroKey != null)
          Hero(
            tag: ObjectKey(heroKey),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(isFromDetail ? 0 : 12),
              child: Image.network(
                model?.thumbUrl ?? Constant.tempImageURL,
                fit: BoxFit.cover,
              ),
            ),
          ),
        if (heroKey == null)
          ClipRRect(
            borderRadius: BorderRadius.circular(isFromDetail ? 0 : 12),
            child: Image.network(
              model?.thumbUrl ?? Constant.tempImageURL,
              fit: BoxFit.cover,
            ),
          ),
        const SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isFromDetail ? 16 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                model?.name ?? '',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                model?.tags.join(' · ') ?? '떡볶이 · 치즈 · 매운맛',
                style: const TextStyle(
                  color: BODY_TEXT_COLOR,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _IconText(
                    icon: Icons.star,
                    label: model?.ratings.toString() ?? '',
                  ),
                  renderDot(),
                  _IconText(
                    icon: Icons.receipt,
                    label: model?.ratingsCount.toString() ?? '',
                  ),
                  renderDot(),
                  _IconText(
                    icon: Icons.timeline_outlined,
                    label: '${model?.deliveryTime ?? 0} 분',
                  ),
                  renderDot(),
                  _IconText(
                    icon: Icons.monetization_on,
                    label: model?.deliveryFee == 0
                        ? '무료'
                        : model?.deliveryFee.toString() ?? '',
                  ),
                ],
              ),
              if (detail != null && isFromDetail)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(detail!),
                )
            ],
          ),
        )
      ],
    );
  }

  Widget renderDot() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        '·',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IconText({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: PRIMAR_COLOR,
          size: 14,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
