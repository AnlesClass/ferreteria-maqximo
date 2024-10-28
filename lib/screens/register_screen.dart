import 'package:app_ferreteria/models/user.dart';
import 'package:app_ferreteria/services/user_service.dart';
import 'package:app_ferreteria/themes/classic_theme.dart';
import 'package:app_ferreteria/widgets/custom_button_widget.dart';
import 'package:app_ferreteria/widgets/custom_drop_down_button_widget.dart';
import 'package:app_ferreteria/widgets/custom_text_form_field_login_register.dart';
import 'package:flutter/material.dart';

// Definición de las opciones para el Cargo
final List<DropdownMenuItem<String>> cargoOptions = [
  const DropdownMenuItem(value: "1", child: Text("Administrador")),
  const DropdownMenuItem(value: "2", child: Text("Empleado")),
];

// Definición de las opciones para la Sede
final List<DropdownMenuItem<String>> sedeOptions = [
  const DropdownMenuItem(value: "1", child: Text("Sede 1")),
  const DropdownMenuItem(value: "2", child: Text("Sede 2")),
  const DropdownMenuItem(value: "3", child: Text("Sede 3"))
];

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final UserService userService = UserService("http://localhost:3000");

  String selectedCargo = "1"; // Valor inicial
  String selectedSede = "1"; // Valor inicial
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contraseniaController = TextEditingController();

  bool estado = true;

  Future<void> addUser(User user, BuildContext context) async {
    final isSuccess = await userService.addUser(user);
    if (isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Usuario registrado exitosamente'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No se pudo registrar el usuario'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ClassicTheme.primary,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          "Registrar Usuario",
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: ClassicTheme.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "assets/images/placeholder_logo_maqximo.png",
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                // CARGO CAMPO
                SizedBox(
                  width: 400,
                  child: CustomDropDownButton(
                    backgroundColor: Colors.white,
                    borderColor: Colors.black,
                    sizeBorder: 0,
                    initValue: selectedCargo,
                    itemsList: cargoOptions,
                    onChange: (value) {
                      setState(() {
                        selectedCargo = value.toString();
                      });
                    },
                  ),
                ),
                const SizedBox(height: 15),
                // SEDE CARGO
                SizedBox(
                  width: 400,
                  child: CustomDropDownButton(
                    backgroundColor: Colors.white,
                    borderColor: Colors.black,
                    sizeBorder: 0,
                    initValue: selectedSede,
                    itemsList: sedeOptions,
                    onChange: (value) {
                      setState(() {
                        selectedSede = value.toString();
                      });
                    },
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: 400,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        // NOMBRE CAMPO
                        child: CustomTextFormFieldLoginRegister(
                          controller: nombreController,
                          validator: (_) => "",
                          labelText: "Nombre",
                          hintText: "Ingresar Nombre",
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        // APELLIDO CAMPO
                        child: CustomTextFormFieldLoginRegister(
                          controller: apellidoController,
                          validator: (_) => "",
                          labelText: "Apellido",
                          hintText: "Ingresar Apellido",
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                // EMAIL CAMPO
                CustomTextFormFieldLoginRegister(
                  controller: emailController,
                  labelText: "Usuario",
                  hintText: "Correo de usuario",
                  validator: (_) => "",
                ),
                // CONTRASENIA CAMPO
                const SizedBox(height: 20),
                CustomTextFormFieldLoginRegister(
                  controller: contraseniaController,
                  iconButton: IconButton(
                    icon:
                        Icon(estado ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() => estado = !estado);
                    },
                  ),
                  obscureText: estado,
                  validator: (_) => "",
                  labelText: "Contraseña",
                  hintText: "Contraseña",
                ),
                const SizedBox(height: 20),
                // BOTON DE REGISTRAR
                CustomButtonWidget(
                    onPressed: () {
                      final user = User(
                        idCargo: int.parse(selectedCargo),
                        idSede: int.parse(selectedSede),
                        nombre: nombreController.text,
                        apellido: apellidoController.text,
                        email: emailController.text,
                        password: contraseniaController.text,
                      );
                      addUser(user, context); // Llama a la función de registro
                    },
                    backgroundColor: ClassicTheme.primary,
                    foregroundColor: const Color(0xF41F2123)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
