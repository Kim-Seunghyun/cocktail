import 'package:flutter/material.dart';

// 사용될 기주(Base Liquor)들의 목록입니다.
enum BaseLiquor {
  whiskey('위스키'),
  gin('진'),
  rum('럼'),
  vodka('보드카'),
  tequila('테킬라'),
  brandy('브랜디'),
  liqueur('리큐르'),
  nonAlcoholic('무알콜'),
  etc('기타');

  // 화면에 보여줄 때 사용할 한글 이름
  final String displayName;
  const BaseLiquor(this.displayName);
}

// 칵테일 색상
enum CocktailColor {
  red('빨간색', Colors.red),
  blue('파란색', Colors.blue),
  green('초록색', Colors.green),
  yellow('노란색', Colors.yellow),
  brown('갈색', Colors.brown),
  clear('투명/흰색', Colors.grey), // 흰색 배경에서 잘 보이도록 회색조 사용
  orange('오렌지색', Colors.orange),
  pink('분홍색', Colors.pink);

  final String displayName;
  final Color displayColor;

  const CocktailColor(this.displayName, this.displayColor);
}

// 칵테일 맛 특징
enum CocktailTaste {
  sweet('달달한'),
  sour('새콤한'),
  bitter('씁쓸한'),
  salty('짭짤한'),
  strong('도수 높은'),
  fresh('상쾌한/청량한'),
  dry('드라이한');

  final String displayName;

  const CocktailTaste(this.displayName);
}

class RecipeIngredient {
  final String name;
  final String amount;

  RecipeIngredient({required this.name, required this.amount});
}

// 칵테일 1잔에 대한 데이터를 담을 '그릇(Model)' 입니다.
class Cocktail {
  final String id;
  final String name;
  final BaseLiquor baseLiquor;
  final List<RecipeIngredient> ingredients;
  final String instructions;
  final String? imageUrl; // 이미지는 없을 수도 있으므로 '?'(nullable) 처리
  final CocktailColor color; // 칵테일 색상
  final List<CocktailTaste> tastes; // 칵테일 맛 특징 리스트

  Cocktail({
    required this.id,
    required this.name,
    required this.baseLiquor,
    required this.ingredients,
    required this.instructions,
    this.imageUrl,
    required this.color,
    required this.tastes,
  });
}
