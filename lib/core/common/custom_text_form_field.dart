import 'package:flutter/material.dart';
import 'package:today_order/core/theme/app_colors.dart';

class CustomTextFormFieldField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool autofocus;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  const CustomTextFormFieldField({
    super.key,
    this.hintText,
    this.autofocus = false,
    this.obscureText = false,
    this.errorText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: INPUT_BORDER_COLOR,
        width: 1,
      ),
    );

    return TextFormField(
      cursorColor: PRIMAR_COLOR,
      autofocus: autofocus,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        errorText: errorText,
        contentPadding: const EdgeInsets.all(20),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: BODY_TEXT_COLOR,
          fontSize: 14,
        ),
        fillColor: INPUT_BG_COLOR,
        filled: true,
        border: baseBorder,
        enabledBorder: baseBorder,
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: PRIMAR_COLOR,
          ),
        ),
      ),
    );
  }
}
