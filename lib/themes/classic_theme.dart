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

    //ESTILO: Elevated Button
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(primary),
        foregroundColor: WidgetStatePropertyAll(Colors.white)
      ),
    ),

    //ESTILO: Filled Button
    filledButtonTheme: const FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(primary)
      )
    ),

    //ESTILO: CheckBox
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return primary;
        }
          return Colors.black45;
      }),
      overlayColor: const WidgetStatePropertyAll(Color(0x50ffaf00)),
      shape: const CircleBorder()
    )
  );
}