import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_order/core/di/di_setup.dart';
import 'package:today_order/core/model/cursor_pagination_model.dart';
import 'package:today_order/core/model/pagination_params.dart';
import 'package:today_order/data/data_source/remote/restaurant_api.dart';
import 'package:today_order/data/repository_impl/restaurant_repository_impl.dart';
import 'package:today_order/domain/model/restaurant_model.dart';

import '../../../core/respository/base_pagination_repository.dart';
import '../../../domain/respository/restaurant_repository.dart';

final restaurantProvider = NotifierProvider<RestaurantNotifier, CursorPaginationBase>(() {
  final restaurantApi = RestaurantApi(getIt<Dio>());
  RestaurantRepository repository =  RestaurantRepositoryImpl(restaurantApi: restaurantApi);
  return RestaurantNotifier(repository: repository);
});

class RestaurantNotifier extends Notifier<CursorPaginationBase> {
  final IBasePaginationRepository repository;

  RestaurantNotifier({
    required this.repository,
  }) {}

  @override
  CursorPaginationBase build() {
    return CursorPaginationLoading();
  }

  Future<void> paginate({
    int fetchCount = 20,
    bool fetchMore = false,
    bool forceRefetch = false,
  }) async {
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
        final pState = state as CursorPagination<RestaurantModel>;

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
          final pState = state as CursorPagination<RestaurantModel>;

          state = CursorPaginationRefetching(
            meta: pState.meta,
            data: pState.data,
          );
        } else { // 나머지 상황
          state = CursorPaginationLoading();
        }
      }

      final response = await repository.paginate(
        paginationParams: paginationParams,
      );

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore<RestaurantModel>;

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
