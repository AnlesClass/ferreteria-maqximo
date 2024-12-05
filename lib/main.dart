import 'package:app_ferreteria/screens/operations_screen.dart';
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
<<<<<<< HEAD
  const String IP = "http://localhost:3000";
=======
  // ignore: constant_identifier_names
  const String IP = "http://192.168.18.133:3000";
>>>>>>> 4cd0031cda59a0945183bac7af6ae25bb13b8e3c
  runApp(
    // llamada a los provider para gestionar estados y mejorar la validaciones
    MultiProvider(
      providers: [
        Provider(create: (_) => UserService(IP)),
        Provider(create: (_) => ExistenciaService(baseURL: IP)),
        Provider(create: (_) => CategoriaService(baseUrl: IP)),
        Provider(create: (_) => ProductService(baseURL: IP)),
        Provider(create: (_) => SedeService(baseURL: IP)),
<<<<<<< HEAD
        Provider(create: (_) => CargosService(baseURL: IP)),
=======
>>>>>>> 4cd0031cda59a0945183bac7af6ae25bb13b8e3c
        ChangeNotifierProvider(
            create: (context) => RegisterViewModel(context.read<UserService>(),
                context.read<SedeService>(), context.read<CargosService>())),
        ChangeNotifierProvider(
            create: (context) => LoginViewModel(context.read<UserService>())),
        ChangeNotifierProvider(create: (context) => ReadExistenceViewModel()),
        ChangeNotifierProvider(
            create: (context) => AddProductViewModel(
                context.read<CategoriaService>(),
                context.read<ProductService>())),
        ChangeNotifierProvider(
          create: (context) => AddProductViewModel(context.read<CategoriaService>(), context.read<ProductService>())),
        ChangeNotifierProvider(
          create: (context) => AddExistenceViewModel(context.read<ProductService>(), context.read<SedeService>(), context.read<ExistenciaService>())),
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
      //se inicia la ruta principal "/" que redirecciona a LoginScreen
      initialRoute: '/',
      //aqui se usa un mapa para establecer cada redireccion un widget determinado
      routes: appRutas,
      title: 'Ferretería Maqximo',
      theme: ClassicTheme.appTheme,
    );
  }
}
