import 'package:today_order/data/data_source/remote/user_api.dart';
import 'package:today_order/domain/model/shopping_cart_item_model.dart';
import 'package:today_order/domain/respository/shopping_cart_repository.dart';

class ShoppingCartRepositoryImpl implements ShoppingCartRepository {
  final UserApi userApi;

  ShoppingCartRepositoryImpl({
    required this.userApi,
  });

  @override
  Future<List<ShoppingCartItemModel>> getShoppingCart() async {
    return await userApi.getShoppingCart();
  }
}
