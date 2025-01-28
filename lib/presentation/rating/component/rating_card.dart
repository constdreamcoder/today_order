import 'package:flutter/material.dart';
import 'package:today_order/core/common/constant/constant.dart';
import 'package:today_order/core/theme/app_colors.dart';

class RatingCard extends StatelessWidget {
  const RatingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Header(),
        const SizedBox(height: 8),
        _Body(),
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: SizedBox(
            height: 100,
            child: _Images(),
          ),
        )
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundImage: NetworkImage(Constant.tempImageURL),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'test@gmail.com',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ...List.generate(
          5,
          (index) => Icon(
            Icons.star,
            color: PRIMAR_COLOR,
          ),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            '안녕하세요.',
            style: const TextStyle(
              color: BODY_TEXT_COLOR,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}

class _Images extends StatelessWidget {
  const _Images({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: List.generate(
        8,
        (index) {
          return Padding(
            padding: EdgeInsets.only(right: index == (8 - 1) ? 0 : 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(Constant.tempImageURL),
            ),
          );
        },
      ),
    );
  }
}
