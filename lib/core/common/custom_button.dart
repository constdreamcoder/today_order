import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color? foregroundColor;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final Widget child;

  const CustomButton({
    super.key,
    this.foregroundColor,
    this.backgroundColor,
    this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          )),
      child: child,
    );
  }
}
