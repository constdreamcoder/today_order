import 'package:flutter/material.dart';

import '../../../core/common/constant.dart';
import '../../../core/theme/app_colors.dart';

class RestaurantCard extends StatelessWidget {
  final bool isFromDetail;

  const RestaurantCard({
    super.key,
    this.isFromDetail = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(isFromDetail ? 0 : 12),
          child: Image.network(
            Constant.tempImageURL,
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
                '불타는 떡볶이',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '떡볶이 · 치즈 · 매운맛',
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
                    label: '4.51',
                  ),
                  renderDot(),
                  _IconText(
                    icon: Icons.receipt,
                    label: '100',
                  ),
                  renderDot(),
                  _IconText(
                    icon: Icons.timeline_outlined,
                    label: '15 분',
                  ),
                  renderDot(),
                  _IconText(
                    icon: Icons.monetization_on,
                    label: '2000',
                  ),
                ],
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
