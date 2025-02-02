import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:today_order/core/component/custom_button.dart';
import 'package:today_order/core/layout/default_layout.dart';
import 'package:today_order/core/routing/provider/router_provider.dart';
import 'package:today_order/core/routing/route_paths.dart';
import 'package:today_order/core/theme/app_colors.dart';

class OrderDoneScreen extends StatelessWidget {
  const OrderDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.thumb_up_alt_outlined,
              color: PRIMAR_COLOR,
              size: 50,
            ),
            const SizedBox(height: 32),
            const Text(
              '결제가 완료되었습니다.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            CustomButton(
              onPressed: (){
                context.go(RoutePaths.restaurant);
              },
              foregroundColor: Colors.white,
              backgroundColor: PRIMAR_COLOR,
              child: const Text('홈으로'),
            ),
          ],
        ),
      ),
    );
  }
}
