import 'package:app_ferreteria/screens/screens.dart';
import 'package:app_ferreteria/services/services.dart';
import 'package:app_ferreteria/themes/classic_theme.dart';
import 'package:app_ferreteria/view_models/view_models.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // llamada a los provider para gestionar estados y mejorar la validaciones
    MultiProvider(
      providers: [
        Provider(create: (_) => UserService("http://192.168.18.133:3000")),
        Provider(create: (_) => CategoriaService(baseUrl: "http://192.168.18.133:3000")),
        Provider(create: (_) => ProductService(baseURL: "http://192.168.18.133:3000")),
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