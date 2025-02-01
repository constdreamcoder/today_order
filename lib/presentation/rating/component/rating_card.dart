import 'package:flutter/material.dart';
import 'package:today_order/core/theme/app_colors.dart';

import '../../../core/constant/constant.dart';
import '../../../domain/model/rating_model.dart';

class RatingCard extends StatelessWidget {
  final RatingModel model;

  const RatingCard({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Header(
          email: model.user.username,
          ratings: model.rating,
        ),
        const SizedBox(height: 8),
        _Body(
          content: model.content,
        ),
        if (model.imgUrls.length > 0)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SizedBox(
              height: 100,
              child: _Images(
                images: model.imgUrls,
              ),
            ),
          )
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final String email;
  final int ratings;

  const _Header({
    super.key,
    required this.email,
    required this.ratings,
  });

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
            email,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ...List.generate(
          5,
          (index) => Icon(
            index < ratings ? Icons.star : Icons.star_border_outlined,
            color: PRIMAR_COLOR,
          ),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final String content;

  const _Body({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            content,
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
  final List<String> images;

  const _Images({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: List.generate(
        images.length,
        (index) {
          final image = images[index];
          return Padding(
            padding:
                EdgeInsets.only(right: index == (images.length - 1) ? 0 : 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(image),
            ),
          );
        },
      ),
    );
  }
}
