import 'package:app_ferreteria/themes/classic_theme.dart';
import 'package:app_ferreteria/widgets/custom_text_form_field_login_register.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ClassicTheme.primary,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // Imagen del logo maqximo
                  Container(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      "assets/images/placeholder_logo_maqximo.png",
                      width: 300,
                      height: 350,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Campo de Usuario
                  CustomTextFormFieldLoginRegister(
                      controller: TextEditingController(),
                      labelText: "Usuario",
                      hintText: "Correo de usuario",
                      validator: (_) => ""),
                  const SizedBox(height: 20),
                  CustomTextFormFieldLoginRegister(
                      controller: TextEditingController(),
                      validator: (_) => "",
                      labelText: "Contraseña",
                      hintText: "Contraseña"),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 200, 104),
                      foregroundColor: const Color.fromARGB(244, 31, 33, 35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                    ),
                    onPressed: () => "",
                    child: const Text("Iniciar Sesión"),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
