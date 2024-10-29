import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  const CustomButtonWidget(
      {super.key,
      required this.onPressed,
      required this.backgroundColor,
      required this.foregroundColor,
      required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      ),
      onPressed: onPressed,
      child: const Text("Registrar Usuario"),
    );
  }
}
