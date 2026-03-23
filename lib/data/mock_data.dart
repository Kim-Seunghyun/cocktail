import '../models/cocktail.dart';

class MockData {
  // 앱에서 사용할 임시 칵테일 데이터 목록입니다.
  static List<Cocktail> cocktails = [
    Cocktail(
      id: '1',
      name: '진 피즈 (Gin Fizz)',
      baseLiquor: BaseLiquor.gin,
      ingredients: [
        RecipeIngredient(name: '진', amount: '45ml'),
        RecipeIngredient(name: '레몬 주스', amount: '30ml'),
        RecipeIngredient(name: '설탕 시럽', amount: '15ml'),
        RecipeIngredient(name: '탄산수', amount: '적당량'),
      ],
      instructions:
          '1. 얼음이 담긴 셰이커에 진, 레몬 주스, 시럽을 넣고 세게 흔듭니다.\n2. 얼음이 담긴 하이볼 글라스에 거른 후 탄산수를 채웁니다.',
    ),
    Cocktail(
      id: '2',
      name: '진 토닉 (Gin & Tonic)',
      baseLiquor: BaseLiquor.gin,
      ingredients: [
        RecipeIngredient(name: '진', amount: '45ml'),
        RecipeIngredient(name: '토닉 워터', amount: '적당량'),
        RecipeIngredient(name: '라임 조각', amount: '장식용'),
      ],
      instructions:
          '1. 얼음이 가득 찬 글라스에 진을 붓습니다.\n2. 토닉 워터로 잔을 채우고 라임 조각으로 장식합니다.',
    ),
    Cocktail(
      id: '3',
      name: '마티니 (Martini)',
      baseLiquor: BaseLiquor.gin,
      ingredients: [
        RecipeIngredient(name: '진', amount: '60ml'),
        RecipeIngredient(name: '드라이 베르무트', amount: '15ml'),
        RecipeIngredient(name: '그린 올리브', amount: '1개'),
      ],
      instructions:
          '1. 믹싱 글라스에 얼음과 함께 진, 베르무트를 넣고 젓습니다.\n2. 차갑게 보관한 마티니 글라스에 거른 후 올리브 장식을 올립니다.',
    ),
    Cocktail(
      id: '4',
      name: '올드 패션드 (Old Fashioned)',
      baseLiquor: BaseLiquor.whiskey,
      ingredients: [
        RecipeIngredient(name: '위스키(버번 또는 라이)', amount: '45ml'),
        RecipeIngredient(name: '각설탕', amount: '1개'),
        RecipeIngredient(name: '앙고스투라 비터스', amount: '2대시'),
        RecipeIngredient(name: '물', amount: '약간'),
      ],
      instructions:
          '1. 글라스에 각설탕을 넣고 비터스와 물을 떨어뜨려 녹입니다.\n2. 얼음과 위스키를 넣고 잘 저어줍니다.\n3. 오렌지 껍질로 장식합니다.',
    ),
    Cocktail(
      id: '5',
      name: '모히토 (Mojito)',
      baseLiquor: BaseLiquor.rum,
      ingredients: [
        RecipeIngredient(name: '화이트 럼', amount: '45ml'),
        RecipeIngredient(name: '라임', amount: '반 개'),
        RecipeIngredient(name: '설탕', amount: '2티스푼'),
        RecipeIngredient(name: '민트잎', amount: '6~8장'),
        RecipeIngredient(name: '탄산수', amount: '적당량'),
      ],
      instructions:
          '1. 하이볼 글라스에 라임 조각, 설탕, 민트잎을 넣고 가볍게 으깹니다 (머들링).\n2. 럼과 부순 얼음을 넣고 젓습니다.\n3. 탄산수로 채운 뒤 민트 가지로 장식합니다.',
    ),
  ];

  // 새로운 레시피를 추가할 때 쓸 함수입니다.
  static void addCocktail(Cocktail cocktail) {
    cocktails.add(cocktail);
  }

  // 특정 기주로 만들 수 있는 칵테일만 추려내는 기능입니다.
  static List<Cocktail> getCocktailsByBase(BaseLiquor base) {
    return cocktails.where((c) => c.baseLiquor == base).toList();
  }

  // 레시피 삭제 기능입니다.
  static void deleteCocktail(String id) {
    cocktails.removeWhere((c) => c.id == id);
  }

  // 레시피 순서 변경 기능입니다.
  static void reorderCocktails(BaseLiquor base, int oldIndex, int newIndex) {
    final filtered = getCocktailsByBase(base);

    // ReorderableListView의 특성 상, 아이템을 아래로 이동할 때 newIndex가 이동할 위치보다 1 크게 전달됩니다.
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final itemToMove = filtered[oldIndex];
    cocktails.remove(itemToMove);

    // 삭제된 상태에서 다시 필터링
    final newFiltered = getCocktailsByBase(base);

    if (newIndex >= newFiltered.length) {
      if (newFiltered.isNotEmpty) {
        final lastItemIdx = cocktails.indexOf(newFiltered.last);
        cocktails.insert(lastItemIdx + 1, itemToMove);
      } else {
        cocktails.add(itemToMove);
      }
    } else {
      final targetItem = newFiltered[newIndex];
      final targetIdx = cocktails.indexOf(targetItem);
      cocktails.insert(targetIdx, itemToMove);
    }
  }
}
