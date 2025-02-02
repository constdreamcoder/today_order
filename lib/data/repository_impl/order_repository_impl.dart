import 'package:today_order/data/data_source/remote/order_api.dart';
import 'package:today_order/domain/model/order_model.dart';
import 'package:today_order/domain/model/post_order_body.dart';
import 'package:today_order/domain/model/shopping_cart_item_model.dart';
import 'package:today_order/domain/respository/order_repository.dart';
import 'package:uuid/uuid.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderApi _orderApi;

  OrderRepositoryImpl({
    required OrderApi orderApi,
  }) : _orderApi = orderApi;

  @override
  Future<OrderModel> postOrder(
    List<ShoppingCartItemModel> orderingProducts,
  ) async {
    final uuid = Uuid();

    final id = uuid.v4();

    final body = PostOrderBody(
      id: id,
      products: orderingProducts
          .map(
            (e) => PostOrderBodyProduct(
              productId: e.product.id,
              count: e.count,
            ),
          )
          .toList(),
      totalPrice: orderingProducts.fold(
        0,
        (previous, element) =>
            previous + (element.count * element.product.price),
      ),
      createdAt: DateTime.now().toString(),
    );
    return await _orderApi.postOrder(body: body);
  }
}
