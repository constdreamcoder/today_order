import 'package:today_order/domain/model/order_model.dart';
import 'package:today_order/domain/model/shopping_cart_item_model.dart';

abstract interface class OrderRepository {
  Future<OrderModel> postOrder(
    List<ShoppingCartItemModel> products,
  );
}
