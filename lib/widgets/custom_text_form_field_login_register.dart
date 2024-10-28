// UsuarioField.dart
import 'package:flutter/material.dart';

class CustomTextFormFieldLoginRegister extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final FormFieldValidator<String> validator;
  final bool? autofocus;
  final IconButton? iconButton;
  final bool? obscureText;

  const CustomTextFormFieldLoginRegister({
    super.key,
    this.obscureText,
    this.autofocus,
    this.iconButton,
    required this.controller,
    required this.validator,
    required this.labelText,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: TextFormField(
        controller: controller,
        cursorColor: Colors.black,
        autofocus: autofocus ?? false,
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.black),
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            filled: true,
            fillColor: const Color(0xFFFFFFFF),
            suffixIcon: iconButton),
        validator: validator,
        obscureText: obscureText ?? false,
      ),
    );
  }
}
