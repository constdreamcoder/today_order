import 'package:flutter/material.dart';
import 'package:today_order/core/common/custom_button.dart';

import '../../core/common/custom_text_form_field.dart';
import '../../core/theme/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _Title(),
              const SizedBox(height: 16),
              const _SubTitle(),
              Image.asset(
                'asset/img/misc/logo.png',
                width: MediaQuery.of(context).size.width / 3 * 2,
              ),
              CustomTextFormFieldField(
                hintText: '이메일을 입력해주세요',
                onChanged: (String value) {},
              ),
              CustomTextFormFieldField(
                hintText: '비밀번호를 입력해주세요',
                onChanged: (String value) {},
              ),
              const SizedBox(height: 16),
              CustomButton(
                onPressed: (){},
                foregroundColor: Colors.white,
                backgroundColor: PRIMAR_COLOR,
                child: const Text('로그인'),
              ),
              CustomButton(
                onPressed: (){},
                child: const Text('회원가입'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '환영합니다!',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '이메일과 비밀번호를 입력해서 로그인 해주세요!\n오늘도 성공적인 주문이 되길 :)',
      style: TextStyle(
        fontSize: 16,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
