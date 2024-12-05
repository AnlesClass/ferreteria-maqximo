import 'package:app_ferreteria/screens/screens.dart';
import 'package:flutter/material.dart';

//La clase maneja las ventanas.
class OperationsViewModel extends ChangeNotifier{
  int screenIndex = 0;
  List<dynamic> widgetsOptions = [
    {
      "WIDGET": AddProductScreen(),
      "NAME": "Productos",
      "ICON": Icons.add_circle_outlined
    },
    {
      "WIDGET": AddExistenceScreen(),
      "NAME": "Existencias",
      "ICON": Icons.add_business_sharp
    },
    {
      "WIDGET": const ReadExistenceScreen(),
      "NAME": "Registros",
      "ICON": Icons.receipt_long_outlined
    }
  ];

  void setScreenIndex(int screenIndex){
    this.screenIndex = screenIndex;
    notifyListeners();
  }
}