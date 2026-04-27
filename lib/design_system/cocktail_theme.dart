import 'package:flutter/material.dart';
import 'cocktail_colors.dart';

class CocktailTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      
      // 배경색 지정
      scaffoldBackgroundColor: CocktailColors.background,
      
      // 전체적인 ColorScheme
      colorScheme: const ColorScheme.dark(
        primary: CocktailColors.primary,
        secondary: CocktailColors.accent,
        surface: CocktailColors.surface,
        background: CocktailColors.background,
        onPrimary: Colors.white,
        onSecondary: CocktailColors.background,
        onSurface: CocktailColors.textPrimary,
        onBackground: CocktailColors.textPrimary,
      ),

      // 기본 텍스트 테마
      textTheme: const TextTheme(
        headlineLarge: TextStyle(color: CocktailColors.textPrimary, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(color: CocktailColors.textPrimary, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: CocktailColors.textPrimary),
        bodyMedium: TextStyle(color: CocktailColors.textSecondary),
      ),


      // 앱바 테마
      appBarTheme: const AppBarTheme(
        backgroundColor: CocktailColors.background,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: CocktailColors.accent),
        titleTextStyle: TextStyle(
          color: CocktailColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
