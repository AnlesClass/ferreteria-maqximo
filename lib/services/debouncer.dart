import 'dart:async';

import 'package:flutter/material.dart';

/* NOTE: EXPLICACIÓN DE ESTA CLASE
La clase 'Debouncer' o 'Rebote' al español, es una clase que permite cancelar o retrasar la ejecución de un código N cantidad de tiempo.
Si se llama antes de que la función se active entonces se reinicia y se debe volver a esperar el tiempo designado.

PROPIEDADES

-> VoidCallbackAction: Guarda una función genérica que puede ejecutarse en cualquier momento.
-> Timer: Crea un temporizador que ejecuta la función tras esperar N cantidad de tiempo, puede cancelarse en cualquier momento.
-> miliseconds: Indica la cantidad de tiempo en milisegundos.
*/

class Debouncer {
  final int miliseconds;
  Timer? timer;

  Debouncer({required this.miliseconds});
  
  void execute(VoidCallback action){
    timer?.cancel();  
    timer = Timer(Duration(milliseconds: miliseconds), action);
  }
}