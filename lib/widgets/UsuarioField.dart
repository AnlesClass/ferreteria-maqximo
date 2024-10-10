// UsuarioField.dart
import 'package:flutter/material.dart';

class UsernameField extends StatelessWidget {
  final FormFieldValidator<String> validator;
  const UsernameField({super.key, required this.validator});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: TextFormField(
        cursorColor: Colors.black,
        autofocus: true,
        decoration: InputDecoration(
          labelText: "usuario",
          labelStyle: const TextStyle(color: Colors.black),
          hintText: "Nombre de usuario",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        validator: validator,
      ),
    );
  }
}
