import 'package:flutter/material.dart';

import 'package:app_ferreteria/themes/themes.dart';

class CustomTextField extends StatelessWidget {
  
  final String labelText;
  final String hintText;
  final IconData? icon;
  final int lines;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool isAlwaysLabel;
  final Function(String value)? onChanged;
  
  const CustomTextField({
    super.key,
    required this.controller,
    this.labelText = "<Without Label>",
    this.hintText = "",
    this.lines = 1,
    this.icon,
    this.validator,
    this.keyboardType = TextInputType.name,
    this.isAlwaysLabel = false,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // DIBUJAR: Aspecto del TextField
      controller: controller,
      maxLines: lines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        alignLabelWithHint: true, // Lo alinea.
        floatingLabelBehavior: (isAlwaysLabel) ? FloatingLabelBehavior.always : FloatingLabelBehavior.auto,
        floatingLabelStyle: const TextStyle(
          color: ClassicTheme.primary,
        ),
        labelStyle: const TextStyle(
          color: Colors.black54,
        ),
        hintStyle: const TextStyle(
          color: Colors.black45,
        ),

        // DIBUJAR: Cuando está habilitado (Default)
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          borderSide: BorderSide(
            color: Colors.blueGrey,
            width: 1.5
          )
        ),
        // DIBUJAR: Cuando está enfocado.
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(5),
            topRight: Radius.circular(20),
            topLeft: Radius.circular(5)
          ),
          borderSide: BorderSide(
            width: 2,
            color: Colors.blueGrey.shade300
          ),
        ),
        labelText: labelText,
        hintText: hintText,
        // prefix: Text("Test-Prefix"), - Prefijo a un Texto que se está ingresando.
        prefixIcon: icon != null ? Icon(icon) : null,
        counterText: "1/200", // TODO : Counter Test
      ),
      validator: validator,
      onChanged: onChanged
    );
  }
}