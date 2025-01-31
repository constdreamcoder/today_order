import 'package:flutter/material.dart';
import 'package:today_order/core/model/cursor_pagination_model.dart';

class CursorPaginationLoadingCircle extends StatelessWidget {
  final CursorPagination state;

  const CursorPaginationLoadingCircle({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Center(
        child: state is CursorPaginationFetchingMore
            ? const CircularProgressIndicator()
            : const Text('마지막 데이터입니다~!'),
      ),
    );
  }
}
