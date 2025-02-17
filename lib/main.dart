import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_order/core/routing/routes.dart';
import 'package:today_order/core/theme/app_colors.dart';
import 'package:today_order/data/data_source/remote/product_api.dart';
import 'package:today_order/data/repository_impl/product_repository_impl.dart';
import 'package:today_order/presentation/root_tab.dart';
import 'package:today_order/presentation/user/screen/login_screen.dart';

import 'core/di/di_setup.dart';
import 'core/routing/provider/router_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  // diSetup();
  configureDependencies();
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
