import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:today_order/core/routing/route_paths.dart';
import 'package:today_order/core/routing/routes.dart';
import 'package:today_order/presentation/user/provider/auth_provider.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    final provider = ref.read(authProvider);

    return GoRouter(
      routes: routes,
      initialLocation: RoutePaths.splash,
      refreshListenable: provider,
      redirect: provider.redirectLogic,
    );
  },
);
