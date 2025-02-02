import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_order/core/component/custom_button.dart';
import 'package:today_order/core/constant/constant.dart';
import 'package:today_order/core/layout/default_layout.dart';
import 'package:today_order/core/theme/app_colors.dart';
import 'package:today_order/domain/model/restaurant_detail_model.dart';
import 'package:today_order/presentation/product/component/product_card.dart';
import 'package:today_order/presentation/restaurant/provider/shopping_cart_provider.dart';

class ShoppingCartScreen extends ConsumerWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shoppingCartState = ref.watch(shoppingCartProvider);

    if (shoppingCartState.isEmpty) {
      return const DefaultLayout(
        title: '장바구니',
        body: Center(
          child: Text(
            '장바구니가 비어있습니다.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final productsTotal = shoppingCartState.fold(
      0,
      (previous, element) {
        return previous + (element.product.price * element.count);
      },
    );

    final deliveryFee = shoppingCartState.first.product.restaurant.deliveryFee;

    return DefaultLayout(
      title: '장바구니',
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (_, index) {
                    return const Divider(height: 32);
                  },
                  itemCount: shoppingCartState.length,
                  itemBuilder: (context, index) {
                    final product = shoppingCartState[index].product;
                    return ProductCard.fromProductModel(
                      model: product,
                      onSubtract: () {
                        ref
                            .read(shoppingCartProvider.notifier)
                            .removeFromShoppingCart(
                              product: product,
                            );
                      },
                      onAdd: () {
                        ref
                            .read(shoppingCartProvider.notifier)
                            .addToShoppingCart(
                              product: product,
                            );
                      },
                    );
                  },
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '장바구니 금액',
                        style: TextStyle(
                          color: BODY_TEXT_COLOR,
                        ),
                      ),
                      if (shoppingCartState.isNotEmpty)
                        Text(
                          '₩$productsTotal',
                        ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '배달비',
                        style: TextStyle(
                          color: BODY_TEXT_COLOR,
                        ),
                      ),
                      // if(shopingCart.length > 0)
                      Text(
                        '₩$deliveryFee',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '총액',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '₩${deliveryFee + productsTotal}',
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      onPressed: () async {
                        final isPassed = await ref.read(shoppingCartProvider.notifier).postOrder();
                        print(isPassed);
                      },
                      foregroundColor: Colors.white,
                      backgroundColor: PRIMAR_COLOR,
                      child: const Text('결제하기'),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
