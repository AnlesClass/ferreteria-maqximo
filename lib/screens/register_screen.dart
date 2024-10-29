import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/register_view_model.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/custom_text_form_field_login_register.dart';
import '../widgets/custom_drop_down_button_widget.dart';
import '../themes/classic_theme.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Accede al ViewModel usando Provider
    final viewModel = Provider.of<RegisterViewModel>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(206, 255, 162, 0),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          "Registrar Usuario",
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(height: 215),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 162, 0),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(500),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(20))),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topCenter,
                      child: Image.network(
                        "https://cdn-icons-png.flaticon.com/512/552/552721.png",
                        width: 280,
                        height: 190,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const SizedBox(
                        width: 400, child: Text("Seleccionar Cargo:")),
                    // Campo Cargo
                    SizedBox(
                      width: 400,
                      child: CustomDropDownButton(
                        backgroundColor: const Color(0x46FFFFFF),
                        borderColor: Colors.transparent,
                        sizeBorder: 0,
                        initValue: viewModel.selectedCargo,
                        itemsList: viewModel.cargoOptions,
                        onChange: (value) {
                          viewModel.selectedCargo = value.toString();
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(
                        width: 400, child: Text("Seleccionar Sede:")),
                    // Campo Sede
                    SizedBox(
                      width: 400,
                      child: CustomDropDownButton(
                        backgroundColor: const Color(0x46FFFFFF),
                        borderColor: Colors.transparent,
                        sizeBorder: 0,
                        initValue: viewModel.selectedSede,
                        itemsList: viewModel.sedeOptions,
                        onChange: (value) {
                          viewModel.selectedSede = value.toString();
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
                            child: CustomTextFormFieldLoginRegister(
                              controller: viewModel.nombreController,
                              validator: (value) =>
                                  viewModel.validarNombre(value ?? ""),
                              labelText: "Nombre",
                              hintText: "Ingresar Nombre",
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            flex: 1,
                            child: CustomTextFormFieldLoginRegister(
                              controller: viewModel.apellidoController,
                              validator: (value) =>
                                  viewModel.validarApellido(value ?? ""),
                              labelText: "Apellido",
                              hintText: "Ingresar Apellido",
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Campo Email
                    CustomTextFormFieldLoginRegister(
                      controller: viewModel.emailController,
                      labelText: "Usuario",
                      hintText: "Correo de usuario",
                      validator: (value) => viewModel.validarEmail(value ?? ""),
                    ),
                    const SizedBox(height: 15),
                    // Campo Contraseña
                    CustomTextFormFieldLoginRegister(
                      controller: viewModel.contraseniaController,
                      labelText: "Contraseña",
                      hintText: "Contraseña",
                      obscureText: viewModel.estado,
                      iconButton: IconButton(
                        icon: Icon(viewModel.estado
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: viewModel.togglePasswordVisibility,
                      ),
                      validator: (value) =>
                          viewModel.validarContrasenia(value ?? ""),
                    ),
                    const SizedBox(height: 30),
                    // Botón de Registro
                    CustomButtonWidget(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final success = await viewModel.registerUser();
                          final message = success
                              ? "Registro exitoso"
                              : "Error en el registro";
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(message)));
                        }
                      },
                      backgroundColor: const Color.fromARGB(255, 255, 175, 36),
                      foregroundColor: const Color.fromARGB(244, 0, 0, 0),
                      borderColor: const Color.fromARGB(127, 207, 155, 65),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
