import '../model/cursor_pagination_model.dart';
import '../model/model_with_id.dart';
import '../model/pagination_params.dart';
import 'base_pagination_repository.dart';

abstract interface class IBasePaginationRepositoryWithoutPath<
    T extends IModelWithId> implements IBasePaginationRepository<T> {
  Future<CursorPagination<T>> paginate({
    PaginationParams? paginationParams,
  });
}
