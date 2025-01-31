import 'package:today_order/core/model/model_with_id.dart';
import 'package:today_order/core/model/pagination_params.dart';

import '../model/cursor_pagination_model.dart';

abstract interface class IBasePaginationRepository<T extends IModelWithId> {
  Future<CursorPagination<T>> paginate({
    PaginationParams? paginationParams,
  });
}
