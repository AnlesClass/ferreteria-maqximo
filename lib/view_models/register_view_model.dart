import 'package:app_ferreteria/models/user.dart';
import 'package:app_ferreteria/services/user_service.dart';
import 'package:app_ferreteria/view_models/form_view_model_base.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends FormViewModelBase {
  final UserService _userService;
  String selectedCargo = "1";
  String selectedSede = "1";
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contraseniaController = TextEditingController();
  RegisterViewModel(this._userService);

  Future<bool> registerUser() async {
    if (!validarCampos()) return false;
    final user = User(
        idCargo: int.parse(selectedCargo),
        idSede: int.parse(selectedSede),
        nombre: nombreController.text,
        apellido: apellidoController.text,
        email: emailController.text,
        password: contraseniaController.text);
    return await _userService.addUser(user);
  }

  bool validarCampos() {
    return validarEmail(emailController.text) == null &&
        validarContrasenia(contraseniaController.text) == null &&
        validarTexto(nombreController.text, "nombre") == null &&
        validarTexto(apellidoController.text, "apellido") == null;
  }

// Definición de las opciones para los Cargos
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
}
