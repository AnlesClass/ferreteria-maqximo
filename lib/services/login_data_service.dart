import 'package:flutter/material.dart';

class LoginDataService extends ChangeNotifier{
  late int idUsuario;
  late int idCargo;
  late int idSede;
  
  void setIdUsuario(int idUsuario){
    this.idUsuario = idUsuario;
    notifyListeners();
  }
  
  void setIdCargo(int idCargo){
    this.idCargo = idCargo;
    notifyListeners();
  }

  void setIdSede(int idSede){
    this.idSede = idSede;
    notifyListeners();
  }
}