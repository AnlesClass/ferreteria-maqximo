import 'dart:math';

import 'package:app_ferreteria/screens/login_screen.dart';
import 'package:app_ferreteria/screens/register_screen.dart';
import 'package:app_ferreteria/services/categoria_service.dart';
import 'package:app_ferreteria/services/product_service.dart';
import 'package:app_ferreteria/services/user_service.dart';
import 'package:app_ferreteria/themes/classic_theme.dart';
import 'package:app_ferreteria/view_models/add_product_view_model.dart';
import 'package:app_ferreteria/view_models/login_view_model.dart';
import 'package:app_ferreteria/view_models/read_existence_view_model.dart';
import 'package:app_ferreteria/view_models/register_view_model.dart';
import 'package:flutter/material.dart';

import 'package:app_ferreteria/screens/screens.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // llamada a los provider para gestionar estados y mejorar la validaciones
    MultiProvider(
      providers: [
        Provider(create: (_) => UserService("http://localhost:3000")),
        Provider(create: (_) => CategoriaService(baseUrl: "http://localhost:3000")),
        Provider(create: (_) => ProductService(baseURL: "http://localhost:3000")),
        ChangeNotifierProvider(
          create: (context) => RegisterViewModel(context.read<UserService>())),
        ChangeNotifierProvider(
          create: (context) => LoginViewModel(context.read<UserService>())),
        ChangeNotifierProvider(
          create: (context) => ReadExistenceViewModel()),
        ChangeNotifierProvider(
          create: (context) => AddProductViewModel(context.read<CategoriaService>(), context.read<ProductService>()))
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Este Widget es la Raiz de mi App.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ferretería Maqximo',
      theme: ClassicTheme.appTheme,
      home: AddProductScreen()
    );
  }
}