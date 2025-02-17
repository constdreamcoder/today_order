import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_order/domain/model/rating_model.dart';

import '../../../core/di/di_setup.dart';
import '../../../core/model/cursor_pagination_model.dart';
import '../../../core/model/pagination_params.dart';
import '../../../domain/respository/restaurant_rating_repository.dart';

class _RestaurantDetailPaginationInfo {
  final String id;
  final int fetchCount;
  final bool fetchMore;
  final bool forceRefetch;

  _RestaurantDetailPaginationInfo({
    this.id = '',
    this.fetchCount = 20,
    this.fetchMore = false,
    this.forceRefetch = false,
  });
}

final restaurantRatingProvider =
NotifierProvider<RestaurantRatingNotifier, CursorPaginationBase>(() {
  return RestaurantRatingNotifier(repository: getIt<RestaurantRatingRepository>());
});

class RestaurantRatingNotifier extends Notifier<CursorPaginationBase> {
  final RestaurantRatingRepository _repository;
  final _paginationThrottle = Throttle(
    const Duration(seconds: 3),
    initialValue: _RestaurantDetailPaginationInfo(),
    checkEquality: false,
  );

  RestaurantRatingNotifier({
    required RestaurantRatingRepository repository,
  }) : _repository = repository {
    _paginationThrottle.values.listen(
          (state) {
        print(state.forceRefetch);
        _throttledPagination(state);
      },
    );
  }

  @override
  CursorPaginationBase build() {
    // TODO: implement build
    return CursorPaginationLoading();
  }

  Future<void> paginate({
    required String id,
    int fetchCount = 20,
    bool fetchMore = false,
    bool forceRefetch = false,
  }) async {
    _paginationThrottle.setValue(_RestaurantDetailPaginationInfo(
      id: id,
      fetchMore: fetchMore,
      fetchCount: fetchCount,
      forceRefetch: forceRefetch,
    ));
  }

  _throttledPagination(_RestaurantDetailPaginationInfo info) async {
    final id = info.id;
    final fetchCount = info.fetchCount;
    final fetchMore = info.fetchMore;
    final forceRefetch = info.forceRefetch;

    try {
      // hasMore = false인 경우,
      // 기존 상태에서 이미 다음 데이터가 없다는 값을 들고 있다면
      if (state is CursorPagination && !forceRefetch) {
        final pState = state as CursorPagination;

        if (!pState.meta.hasMore) {
          return;
        }
      }

      // 네트워크 통신 중에 중복 통신 방지
      final isLoading = state is CursorPaginationLoading;
      final isRefetching = state is CursorPaginationRefetching;
      final isFetchingMore = state is CursorPaginationFetchingMore;

      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }

      PaginationParams paginationParams = PaginationParams(
        count: fetchCount,
      );

      // 데이터를 추가로 더 가져올 때
      if (fetchMore) {
        final pState = state as CursorPagination<RatingModel>;

        state = CursorPaginationFetchingMore(
          meta: pState.meta,
          data: pState.data,
        );

        paginationParams = paginationParams.copyWith(
          after: pState.data.last.id,
        );
      } else {
        // 데이터를 처음부터 가져오는 상황

        // 만약 기존 데이터가 있는 상황이라면
        // 기존 데이터를 보존한 채 Fetch (API 요청)를 진행
        if (state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination<RatingModel>;

          state = CursorPaginationRefetching<RatingModel>(
            meta: pState.meta,
            data: pState.data,
          );
        } else {
          // 나머지 상황
          state = CursorPaginationLoading();
        }
      }

      final response = await _repository.paginate(
        id: id,
        paginationParams: paginationParams,
      );

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore<RatingModel>;
        state = response.copyWith(
          data: [
            ...pState.data,
            ...response.data,
          ],
        );
      } else {
        state = response;
      }
    } catch (e, stack) {
      print(e);
      print(stack);
      state = CursorPaginationError(message: '데이터를 가져오지 못했습니다.');
    }
  }
}
