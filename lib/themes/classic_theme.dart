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
    ),

    //ESTILO TextField
    inputDecorationTheme: InputDecorationTheme(
      alignLabelWithHint: true, // Lo alinea.
      floatingLabelStyle: const TextStyle(
        color: ClassicTheme.primary,
      ),
      labelStyle: const TextStyle(
        color: Colors.black54,
      ),

      // DIBUJAR: Cuando está habilitado (Default)
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        borderSide: BorderSide(
          color: Colors.blueGrey,
          width: 1.5
        )
      ),
      
      // DIBUJAR: Cuando está enfocado.
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(5),
          topRight: Radius.circular(20),
          topLeft: Radius.circular(5)
        ),
        borderSide: BorderSide(
          width: 2,
          color: Colors.blueGrey.shade300
        ),
      )
    ),

    //ESTILO TextButton
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
          textStyle: WidgetStatePropertyAll(TextStyle(
            fontWeight: FontWeight.w600
          )),
          elevation: WidgetStatePropertyAll(3),
          backgroundColor: WidgetStatePropertyAll(primary),
          foregroundColor: WidgetStatePropertyAll(Colors.white),
          padding: WidgetStatePropertyAll(EdgeInsets.all(20)),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))))
      ),
    ),
  );
}