import 'package:app_ferreteria/rutas.dart';
import 'package:app_ferreteria/screens/screens.dart';
import 'package:app_ferreteria/services/cargos_service.dart';
import 'package:app_ferreteria/services/services.dart';
import 'package:app_ferreteria/themes/themes.dart';
import 'package:app_ferreteria/view_models/view_models.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
export 'rutas.dart';

void main() {
  const String IP = "http://localhost:3000";
  runApp(
    // Llamada a los provider para gestionar estados y mejorar la validaciones
    MultiProvider(
      providers: [
        Provider(create: (_) => UserService(IP)),
        Provider(create: (_) => ExistenciaService(baseURL: IP)),
        Provider(create: (_) => CategoriaService(baseUrl: IP)),
        Provider(create: (_) => ProductService(baseURL: IP)),
        Provider(create: (_) => SedeService(baseURL: IP)),
        Provider(create: (_) => CargosService(baseURL: IP)),
        ChangeNotifierProvider(
            create: (context) => RegisterViewModel(context.read<UserService>(),
                context.read<SedeService>(), context.read<CargosService>())),
        ChangeNotifierProvider(
          create: (context) => LoginViewModel(
            context.read<UserService>())),
        ChangeNotifierProvider(
          create: (context) => ReadExistenceViewModel(
            context.read<ExistenciaService>())),
        ChangeNotifierProvider(
          create: (context) => AddProductViewModel(
            context.read<CategoriaService>(),
            context.read<ProductService>())),
        ChangeNotifierProvider(
          create: (context) => AddProductViewModel(
            context.read<CategoriaService>(),
            context.read<ProductService>())),
        ChangeNotifierProvider(
          create: (context) => AddExistenceViewModel(
            context.read<ProductService>(), 
            context.read<SedeService>(), 
            context.read<ExistenciaService>())),
        ChangeNotifierProvider(
          create: (context) => OperationsViewModel()),
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
      // Se inicia la ruta principal "/" que redirecciona a LoginScreen
      initialRoute: '/read_existence',
      // Aqui se usa un mapa para establecer cada redireccion un Widget determinado
      routes: appRutas,
      title: 'Ferretería Maqximo',
      theme: ClassicTheme.appTheme,
    );
  }
}
