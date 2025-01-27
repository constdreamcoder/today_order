import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:today_order/presentation/root_tab.dart';

final router = GoRouter(
  initialLocation: '/restaurant',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return RootTab(
          body: navigationShell,
          currentPageIndex: navigationShell.currentIndex,
          onChangeIndex: (index) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/restaurant',
              builder: (context, state) {
                return Center(
                  child: Text('홈'),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/product',
              builder: (context, state) {
                return Center(
                  child: Text('음식'),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/order_done',
              builder: (context, state) {
                return Center(
                  child: Text('주문'),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) {
                return Center(
                  child: Text('프로필'),
                );
              },
            ),
          ],
        ),
      ],
    )
  ],
);
