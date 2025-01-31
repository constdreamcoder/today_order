import 'package:today_order/core/model/cursor_pagination_model.dart';
import 'package:today_order/domain/model/product_model.dart';

abstract interface class ProductRepository {
  Future<CursorPagination<ProductModel>> paginate();
}