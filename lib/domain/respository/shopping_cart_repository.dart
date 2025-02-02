import 'package:today_order/domain/model/shopping_cart_item_model.dart';

abstract interface class ShoppingCartRepository {
  Future<List<ShoppingCartItemModel>> getShoppingCart();

  Future<List<ShoppingCartItemModel>> patchShoppingCart({
    required List<ShoppingCartItemModel> newShoppingCartItems,
  });
}
