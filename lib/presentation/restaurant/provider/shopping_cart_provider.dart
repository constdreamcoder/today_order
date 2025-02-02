import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_order/core/di/di_setup.dart';
import 'package:today_order/data/data_source/remote/user_api.dart';
import 'package:today_order/data/repository_impl/shopping_cart_respository_impl.dart';
import 'package:today_order/domain/model/shopping_cart_item_model.dart';
import 'package:today_order/domain/respository/shopping_cart_repository.dart';

final shoppingCartProvider =
    NotifierProvider<ShoppingCartNotifier, List<ShoppingCartItemModel>>(() {
  final userApi = UserApi(getIt<Dio>());
  final repository = ShoppingCartRepositoryImpl(userApi: userApi);
  return ShoppingCartNotifier(repository: repository);
});

class ShoppingCartNotifier extends Notifier<List<ShoppingCartItemModel>> {
  final ShoppingCartRepository repository;

  ShoppingCartNotifier({
    required this.repository,
  });

  @override
  List<ShoppingCartItemModel> build() {
    patchShoppingCart();
    return [];
  }

  Future<void> patchShoppingCart() async {
    await repository.patchShoppingCart(
      newShoppingCartItems: state,
    );
  }
}
