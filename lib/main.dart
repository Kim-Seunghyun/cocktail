import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'design_system/cocktail_theme.dart';

void main() {
  // runApp은 플러터 앱을 시작하는 함수입니다.
  runApp(const CocktailApp());
}

// StatelessWidget은 화면이 갱신될 필요가 없는 '정적인' UI를 만들 때 사용합니다.
class CocktailApp extends StatelessWidget {
  const CocktailApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp은 앱의 전체적인 디자인 테마와 내비게이션(화면 이동)을 관리해주는 뼈대입니다.
    return MaterialApp(
      title: 'Cocktail App',
      theme: CocktailTheme.darkTheme,
      home: const HomeScreen(), // 앱이 켜지면 가장 먼저 보여줄 화면
    );
  }
}

