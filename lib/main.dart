import 'package:flutter/material.dart';
import 'package:today_order/core/common/component/custom_text_form_field.dart';
import 'package:today_order/core/theme/app_colors.dart';
import 'package:today_order/presentation/user/login_screen.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

