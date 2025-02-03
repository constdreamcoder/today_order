import 'package:injectable/injectable.dart';
import 'package:today_order/core/model/cursor_pagination_model.dart';
import 'package:today_order/core/model/pagination_params.dart';
import 'package:today_order/data/data_source/remote/product_api.dart';
import 'package:today_order/domain/model/product_model.dart';
import 'package:today_order/domain/respository/product_repository.dart';

@Singleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductApi _productApi;

  ProductRepositoryImpl({
    required ProductApi productApi,
  }) : _productApi = productApi;

  @override
  Future<CursorPagination<ProductModel>> paginate({
    PaginationParams? paginationParams,
  }) async {
    return await _productApi.paginate(
      paginationParams: paginationParams,
    );
  }
}
