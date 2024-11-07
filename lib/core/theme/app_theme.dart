import 'package:flutter/material.dart';
import 'package:music_player_v1/core/theme/app_palette.dart';

class AppTheme{

  static final lightTheme = ThemeData(
    primaryColor: AppPalette.primary,
    scaffoldBackgroundColor: AppPalette.lightBackground,
    brightness: Brightness.light,
    fontFamily: 'Satoshi',
      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.all(30),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:const BorderSide(
                color: Colors.black,
                width: 0.4,
              )
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:const BorderSide(
                color: Colors.black,
                width: 0.4,
              )
          )
      ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPalette.primary,
        elevation: 0,
        textStyle:const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        )
      )
    )
  );

  static final darkTheme = ThemeData(
      primaryColor: AppPalette.primary,
      scaffoldBackgroundColor: AppPalette.darkBackground,
      brightness: Brightness.dark,
      fontFamily: 'Satoshi',
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: const EdgeInsets.all(30),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 0.4,
          )
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide:const BorderSide(
              color: Colors.white,
              width: 0.4,
            )
        )
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppPalette.primary,
              elevation: 0,
              textStyle:const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              )
          )
      )
  );

}