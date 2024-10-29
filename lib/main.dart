import 'dart:math';

import 'package:app_ferreteria/screens/login_screen.dart';
import 'package:app_ferreteria/screens/register_screen.dart';
import 'package:app_ferreteria/services/user_service.dart';
import 'package:app_ferreteria/view_models/login_view_model.dart';
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
        ChangeNotifierProvider(
            create: (context) =>
                RegisterViewModel(context.read<UserService>())),
        ChangeNotifierProvider(
            create: (context) => LoginViewModel(context.read<UserService>())),
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
        debugShowCheckedModeBanner:
            false, // Indica que está activo el Banner (Se ve feo)
        title: 'Proyecto: Ferretería Maqximo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        //home: const MyHomePage(title: 'Flutter Demo Home Page'),
        home: RegisterScreen()
        //const ReadExistenceScreen()
        );
  }
}

//TODO: Borrar desde aquí hacia abajo.

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
