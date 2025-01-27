import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:today_order/core/common/component/custom_text_form_field.dart';
import 'package:today_order/core/routing/router.dart';
import 'package:today_order/core/theme/app_colors.dart';
import 'package:today_order/presentation/root_tab.dart';
import 'package:today_order/presentation/user/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

