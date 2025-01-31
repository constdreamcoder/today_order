import 'package:today_order/core/model/model_with_id.dart';

import '../model/cursor_pagination_model.dart';

abstract interface class IBasePaginationRepository<T extends IModelWithId> {
  Future<CursorPagination<T>> paginate({
    String? after,
  });
}
