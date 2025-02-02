import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:today_order/core/di/di_setup.dart';
import 'package:today_order/data/data_source/remote/user_api.dart';
import 'package:today_order/data/repository_impl/shopping_cart_respository_impl.dart';
import 'package:today_order/domain/model/product_model.dart';
import 'package:today_order/domain/model/shopping_cart_item_model.dart';
import 'package:today_order/domain/respository/shopping_cart_repository.dart';
import 'package:collection/collection.dart';

import '../../../domain/model/restaurant_detail_model.dart';
import '../../../domain/model/restaurant_model.dart';

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
    // patchShoppingCart();
    return [];
  }

  Future<void> patchShoppingCart() async {
    await repository.patchShoppingCart(
      newShoppingCartItems: state,
    );
  }

  Future<void> addToShoppingCart({
    required ProductModel product,
  }) async {
    final exists =
        state.firstWhereOrNull((e) => e.product.id == product.id) != null;

    if (exists) {
      state = state
          .map(
            (e) => e.product.id == product.id
                ? e.copyWith(
                    count: e.count + 1,
                  )
                : e,
          )
          .toList();
    } else {
      state = [
        ...state,
        ShoppingCartItemModel(
          product: product,
          count: 1,
        ),
      ];
    }

    patchShoppingCart();
  }

  Future<void> removeFromShoppingCart({
    required ProductModel product,
    bool isDelete = false,
  }) async {
    final exists =
        state.firstWhereOrNull((e) => e.product.id == product.id) != null;

    if (!exists) {
      return;
    }

    final existingProduct = state.firstWhere((e) => e.product.id == product.id);

    if (existingProduct.count == 1 || isDelete) {
      state = state
          .where(
            (e) => e.product.id != product.id,
          )
          .toList();
    } else {
      state = state
          .map(
            (e) =>
                e.product.id == product.id ? e.copyWith(count: e.count - 1) : e,
          )
          .toList();
    }

    patchShoppingCart();
  }
}
