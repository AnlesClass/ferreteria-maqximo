import 'package:app_ferreteria/models/user.dart';
import 'package:app_ferreteria/services/cargos_service.dart';
import 'package:app_ferreteria/services/user_service.dart';
import 'package:app_ferreteria/view_models/form_view_model_base.dart';
import 'package:flutter/material.dart';
import 'package:app_ferreteria/services/sede_service.dart';

class RegisterViewModel extends FormViewModelBase {
  final UserService _userService;
  final SedeService _sedeService;
  final CargosService _cargosService;
  String selectedCargo = "1";
  String selectedSede = "1";
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contraseniaController = TextEditingController();

  RegisterViewModel(this._userService, this._sedeService, this._cargosService);

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

  List<DropdownMenuItem<String>> sedeOptions = [];
  List<DropdownMenuItem<String>> cargoOptions = [];

  Future<void> loadCargos() async {
    try {
      final cargos = await _cargosService.getCargos();
      cargoOptions = cargos.map<DropdownMenuItem<String>>((cargo) {
        return DropdownMenuItem<String>(
          value: cargo['IDCARGO'].toString(),
          child: Text(cargo['NOMBRE']),
        );
      }).toList();
      notifyListeners();
    } catch (e) {}
  }

  // DropDownMenuItem de las sedes
  Future<void> loadSedes() async {
    try {
      final sedes = await _sedeService.getSedes();
      sedeOptions = sedes.map<DropdownMenuItem<String>>((sede) {
        return DropdownMenuItem<String>(
          value: sede['IDSEDE'].toString(),
          child: Text(sede['NOMBRE']),
        );
      }).toList();
      notifyListeners();
    } catch (e) {}
  }
}
