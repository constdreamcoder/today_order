import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:today_order/core/routing/route_paths.dart';
import 'package:today_order/core/view/splash_screen.dart';
import 'package:today_order/presentation/restaurant/screen/restaurant_detail_screen.dart';
import 'package:today_order/presentation/root_tab.dart';
import 'package:today_order/presentation/user/screen/login_screen.dart';

import '../../presentation/restaurant/screen/restaurant_screen.dart';

Ref? sharedRef;

List<RouteBase> get routes =>  [
  GoRoute(
    path: RoutePaths.splash,
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: RoutePaths.login,
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: RoutePaths.restaurantIdPath,
    builder: (context, state) => RestaurantDetailScreen(
      id: state.pathParameters[RoutePaths.restaurantId]!,
    ),
  ),
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
            path: RoutePaths.restaurant,
            builder: (context, state) {
              return const RestaurantScreen();
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: RoutePaths.product,
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
            path: RoutePaths.orderDone,
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
            path: RoutePaths.profile,
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
];


// final router = GoRouter(
//   initialLocation: RoutePaths.splash,
//   routes: [
//     GoRoute(
//       path: RoutePaths.splash,
//       builder: (context, state) => const SplashScreen(),
//     ),
//     GoRoute(
//       path: RoutePaths.login,
//       builder: (context, state) => const LoginScreen(),
//     ),
//     GoRoute(
//       path: RoutePaths.restaurantIdPath,
//       builder: (context, state) => RestaurantDetailScreen(
//         id: state.pathParameters[RoutePaths.restaurantId]!,
//       ),
//     ),
//     StatefulShellRoute.indexedStack(
//       builder: (context, state, navigationShell) {
//         return RootTab(
//           body: navigationShell,
//           currentPageIndex: navigationShell.currentIndex,
//           onChangeIndex: (index) {
//             navigationShell.goBranch(
//               index,
//               initialLocation: index == navigationShell.currentIndex,
//             );
//           },
//         );
//       },
//       branches: [
//         StatefulShellBranch(
//           routes: [
//             GoRoute(
//               path: RoutePaths.restaurant,
//               builder: (context, state) {
//                 return const RestaurantScreen();
//               },
//             ),
//           ],
//         ),
//         StatefulShellBranch(
//           routes: [
//             GoRoute(
//               path: RoutePaths.product,
//               builder: (context, state) {
//                 return Center(
//                   child: Text('음식'),
//                 );
//               },
//             ),
//           ],
//         ),
//         StatefulShellBranch(
//           routes: [
//             GoRoute(
//               path: RoutePaths.orderDone,
//               builder: (context, state) {
//                 return Center(
//                   child: Text('주문'),
//                 );
//               },
//             ),
//           ],
//         ),
//         StatefulShellBranch(
//           routes: [
//             GoRoute(
//               path: RoutePaths.profile,
//               builder: (context, state) {
//                 return Center(
//                   child: Text('프로필'),
//                 );
//               },
//             ),
//           ],
//         ),
//       ],
//     )
//   ],
// );
