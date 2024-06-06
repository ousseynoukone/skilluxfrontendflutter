import 'package:flutter/material.dart';
import 'package:skilluxfrontendflutter/config/theme/colors.dart';

class TextAppTheme {
  // private
  TextAppTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: 26.0,fontWeight: FontWeight.w700,color: ColorsTheme.black),
    headlineMedium: const TextStyle().copyWith(fontSize: 20.0,fontWeight: FontWeight.w500,color: ColorsTheme.black),
    headlineSmall: const TextStyle().copyWith(fontSize: 14.0,fontWeight: FontWeight.w100,color: ColorsTheme.black), 

    titleLarge: const TextStyle().copyWith(fontSize: 32.0,fontWeight: FontWeight.bold,color: ColorsTheme.black), 
    titleMedium: const TextStyle().copyWith(fontSize: 24.0,fontWeight: FontWeight.w600,color: ColorsTheme.black),  
    titleSmall: const TextStyle().copyWith(fontSize: 16.0,fontWeight: FontWeight.w200,color: ColorsTheme.black), 

    bodyLarge: const TextStyle().copyWith(fontSize: 28.0,color: ColorsTheme.black),
    bodyMedium: const TextStyle().copyWith(fontSize: 20.0,color: ColorsTheme.black),
    bodySmall: const TextStyle().copyWith(fontSize: 12.0,color: ColorsTheme.black.withOpacity(0.5)),  

    labelLarge: const TextStyle().copyWith(fontSize: 18.0,color: ColorsTheme.black),
    labelMedium: const TextStyle().copyWith(fontSize: 16.0,color: ColorsTheme.black),
    labelSmall: const TextStyle().copyWith(fontSize: 14.0,color: ColorsTheme.black.withOpacity(0.5)),
    
    );
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: 26.0,fontWeight: FontWeight.w700,color: ColorsTheme.white),
    headlineMedium: const TextStyle().copyWith(fontSize: 20.0,fontWeight: FontWeight.w500,color: ColorsTheme.white),
    headlineSmall: const TextStyle().copyWith(fontSize: 14.0,fontWeight: FontWeight.w100,color: ColorsTheme.white), 

    titleLarge: const TextStyle().copyWith(fontSize: 32.0,fontWeight: FontWeight.bold,color: ColorsTheme.white), 
    titleMedium: const TextStyle().copyWith(fontSize: 24.0,fontWeight: FontWeight.w600,color: ColorsTheme.white),  
    titleSmall: const TextStyle().copyWith(fontSize: 16.0,fontWeight: FontWeight.w200,color: ColorsTheme.white), 

    bodyLarge: const TextStyle().copyWith(fontSize: 28.0,color: ColorsTheme.white),
    bodyMedium: const TextStyle().copyWith(fontSize: 20.0,color: ColorsTheme.white),
    bodySmall: const TextStyle().copyWith(fontSize: 12.0,color: ColorsTheme.white.withOpacity(0.5)),  

    labelLarge: const TextStyle().copyWith(fontSize: 18.0,color: ColorsTheme.white),
    labelMedium: const TextStyle().copyWith(fontSize: 16.0,color: ColorsTheme.white),
    labelSmall: const TextStyle().copyWith(fontSize: 14.0,color: ColorsTheme.white.withOpacity(0.5)),
  );
}
