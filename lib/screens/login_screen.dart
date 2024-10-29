import 'package:app_ferreteria/themes/classic_theme.dart';
import 'package:app_ferreteria/view_models/login_view_model.dart';
import 'package:app_ferreteria/widgets/custom_button_widget.dart';
import 'package:app_ferreteria/widgets/custom_text_form_field_login_register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginViewmodel = Provider.of<LoginViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Iniciar Sesion",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          leading: const Icon(
            Icons.supervised_user_circle_outlined,
            size: 50,
          ),
        ),
        backgroundColor: ClassicTheme.primary,
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Center(
                child: Column(
              children: [
                const SizedBox(height: 320),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xDCFFB433),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(
                            MediaQuery.of(context).size.width * 0.05),
                        topLeft: Radius.circular(
                            MediaQuery.of(context).size.width * 0.05),
                      ),
                    ),
                  ),
                )
              ],
            )),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // Imagen del logo maqximo
                      Container(
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          "assets/images/placeholder_logo_maqximo.png",
                          width: 300,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 50),
                      // Campo de Usuario
                      CustomTextFormFieldLoginRegister(
                          controller: loginViewmodel.usuarioController,
                          labelText: "Usuario",
                          hintText: "Correo de usuario",
                          validator: (value) =>
                              loginViewmodel.validarEmail(value ?? "")),
                      const SizedBox(height: 20),
                      // Campo Contraseña
                      CustomTextFormFieldLoginRegister(
                        controller: loginViewmodel.contraseniaController,
                        obscureText: loginViewmodel.estado,
                        labelText: "Contraseña",
                        hintText: "Contraseña",
                        validator: (value) =>
                            loginViewmodel.validarContrasenia(value ?? ""),
                        iconButton: IconButton(
                          icon: Icon(loginViewmodel.estado
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: loginViewmodel.togglePasswordVisibility,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Boton de Iniciar Sesion
                      CustomButtonWidget(
                        contenido: const Text("Iniciar Sesion"),
                        onPressed: () async {
                          // Valida el formulario antes de hacer login
                          if (_formKey.currentState!.validate()) {
                            final success = await loginViewmodel.login();
                            final message = success
                                ? "Inicio de sesión exitoso"
                                : "Usuario o contraseña incorrectos";
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(message)));
                          }
                        },
                        backgroundColor: ClassicTheme.primary,
                        foregroundColor: Colors.black,
                        borderColor: const Color.fromARGB(35, 255, 255, 255),
                      ),
                      const SizedBox(height: 15),
                      const EtiquetaMaqximo()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class EtiquetaMaqximo extends StatelessWidget {
  const EtiquetaMaqximo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Ferreteria Maqximo",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "!Si lo necesitas,te lo conseguimos!",
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
