import 'package:flutter/material.dart';

// Clase base para las validaciones de campos en un formulario
class FormViewModelBase extends ChangeNotifier {
  bool estado = true;

  // Cambio de estado de la visibilidad de la contraseña
  void togglePasswordVisibility() {
    estado = !estado;
    notifyListeners();
  }

  // Validacion de Email
  String? validarEmail(String value) {
    if (value.isEmpty) {
      return "Por favor ingrese el correo";
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return "Ingrese un correo valido";
    }
    return null;
  }

  // Validación de Contraseña
  String? validarContrasenia(String value) {
    int cantidadContrasenia = 3;
    if (value.isEmpty) {
      return "Por favor ingrese la contraseña";
    } else if (value.length < cantidadContrasenia) {
      return 'La contraseña debe tener al menos $cantidadContrasenia caracteres';
    }
    return null;
  }

// Validar todo tipo de texto para evitar ingresos vacios
  String? validarTexto(String value, String nombreCampo, {int minLength = 0, int maxLength = 256}) {
    if (value.isEmpty) return "Por favor ingrese $nombreCampo";
    if (value.length <= minLength) return "La longitud mínima de $nombreCampo es de $minLength caracteres.";
    if (value.length > maxLength) return "La longitud máxima de $nombreCampo es de $maxLength caracteres.";

    return null;
  }
}
