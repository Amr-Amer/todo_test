import 'dart:ui';

import 'package:flutter/material.dart';

class MyTheme {

  static Color backgroundLight = const Color(0xffE6E6E6) ;
  static Color primaryColor = const Color(0xffFAA885) ;
  static Color blackColor = const Color(0xff000000) ;
  static Color lableColor = const Color(0x99000000) ;
  static Color witheColor = const Color(0xffFFFFFF) ;
  static Color brownColor = const Color(0xffAD491E) ;
  static Color backgroundOwner = const Color(0xffCF7751) ;

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: backgroundLight ,
    primaryColor: primaryColor ,
    textTheme: const TextTheme(
      titleSmall: TextStyle(
        fontSize: 15, fontWeight: FontWeight.w400
      ),
      titleMedium: TextStyle(
          fontSize: 15 ,
          fontWeight: FontWeight.w500),
      titleLarge: TextStyle(
            fontSize: 20 ,
            fontWeight: FontWeight.w500),

    ),

      elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(MyTheme.backgroundOwner)
      )),

      dialogBackgroundColor: MyTheme.backgroundLight,

      textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(
        primary:  MyTheme.brownColor ,textStyle: TextStyle(fontSize: 15 , fontWeight: FontWeight.w500))),

      checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStatePropertyAll(MyTheme.primaryColor),
    )

  );
  
}