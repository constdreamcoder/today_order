import 'package:flutter/material.dart';
import 'package:today_order/core/component/custom_button.dart';
import 'package:today_order/core/constant/constant.dart';
import 'package:today_order/core/layout/default_layout.dart';
import 'package:today_order/core/theme/app_colors.dart';
import 'package:today_order/domain/model/restaurant_detail_model.dart';
import 'package:today_order/presentation/product/component/product_card.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '장바구니',
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (_, index) {
                    return const Divider(height: 32);
                  },
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    final model = RestaurantProductModel(
                      id: 'dlfjisleifjlse',
                      name: 'sleifjsliejf',
                      imgUrl: Constant.tempImageURL,
                      detail: '안녕하세요',
                      price: 1000,
                    );
                    return ProductCard(model: model);
                  },
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '장바구니 금액',
                        style: TextStyle(
                          color: BODY_TEXT_COLOR,
                        ),
                      ),
                      Text(
                        '₩${10003}',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '배달비',
                        style: TextStyle(
                          color: BODY_TEXT_COLOR,
                        ),
                      ),
                      // if(shopingCart.length > 0)
                      Text(
                        '₩${1200}',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '총액',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '₩${10000 + 200000}',
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      onPressed: (){},
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
