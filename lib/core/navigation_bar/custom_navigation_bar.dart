import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          label: '홈',
        ),
        NavigationDestination(
          icon: Icon(Icons.fastfood_outlined),
          label: '음식',
        ),
        NavigationDestination(
          icon: Icon(Icons.receipt_long_outlined),
          label: '주문',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          label: '프로필',
        ),
      ],
    );
  }
}
