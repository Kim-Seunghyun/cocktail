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

  Cocktail({
    required this.id,
    required this.name,
    required this.baseLiquor,
    required this.ingredients,
    required this.instructions,
    this.imageUrl,
  });
}
