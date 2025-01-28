import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:today_order/core/routing/route_paths.dart';
import 'package:today_order/domain/model/user_model.dart';

final authProvider = ChangeNotifierProvider<AuthNotifier>(
  (ref) {
    return AuthNotifier();
  },
);

class AuthNotifier extends ChangeNotifier {
  AuthNotifier() : super();

  String? redirectLogic(BuildContext context, GoRouterState state) {
    // 유저 정보를 가져온다.
    final UserModelBase? user = UserModel(id: '1', username: '22', imageUrl: '23123');

    final loggingIn = state.matchedLocation == RoutePaths.login;

    if (user == null) {
      return loggingIn ? null : RoutePaths.login;
    }

    if (user is UserModel) {
      return loggingIn || state.matchedLocation == RoutePaths.splash
          ? RoutePaths.restaurant
          : null;
    }

    if (user is UserModelError) {
      return !loggingIn ? RoutePaths.login : null;
    }

    return null;
  }
}
