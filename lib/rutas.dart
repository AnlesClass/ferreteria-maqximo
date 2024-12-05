import 'package:app_ferreteria/screens/operations_screen.dart';
import 'package:flutter/material.dart';
import 'screens/add_existence_screen.dart';
import 'screens/add_product_screen.dart';
import 'screens/login_screen.dart';
import 'screens/read_existence_screen.dart';
import 'screens/register_screen.dart';

// mapa donde se nombra a cada ruta para su respectivo Widget
Map<String, WidgetBuilder> appRutas = {
  '/': (context) => LoginScreen(),
  '/register': (context) => RegisterScreen(),
  '/add_existence': (context) => AddExistenceScreen(),
  '/add_product': (context) => AddProductScreen(),
  '/read_existence': (context) => const ReadExistenceScreen(),
  '/operations': (context) => const OperationsScreen()
};
