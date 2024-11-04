import 'package:flutter/material.dart';

class ClassicTheme{
  static const Color primary = Color(0xffffa000);

  //TEMA: Claro, General.
  static final ThemeData appTheme = ThemeData.light().copyWith(
    //ESTILO: AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      centerTitle: true,
      elevation: 2,
    ),

    //ESTILO: 
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(primary),
        foregroundColor: WidgetStatePropertyAll(Colors.white)
      ),
    )
  );
}