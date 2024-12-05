import 'package:app_ferreteria/services/services.dart';
import 'package:app_ferreteria/services/user_service.dart';
import 'package:app_ferreteria/view_models/form_view_model_base.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends FormViewModelBase {
  final UserService _userService;
  final LoginDataService _loginDataService;
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController contraseniaController = TextEditingController();

//Constructor con parametro del servicio Usuario
  LoginViewModel(this._userService, this._loginDataService);

// funcion principal para el login
  Future<bool> login() async {
    if (!validarCampos()) return false;

    final res = await _userService.loginUser(
      usuarioController: usuarioController,
      contraseniaController: contraseniaController
    );
    
    if (res.isEmpty){
      return false;
    } else {
      _loginDataService.setIdUsuario(res['IDUSUARIO']!);
      _loginDataService.setIdCargo(res["IDCARGO"]!);
      _loginDataService.setIdSede(res["IDSEDE"]!);
      return true;
    } 
  }

// Validar que los campos no esten nulos
  bool validarCampos() {
    return validarEmail(usuarioController.text) == null &&
        validarContrasenia(contraseniaController.text) == null;
  }
}
