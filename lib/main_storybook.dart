import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import 'design_system/cocktail_theme.dart';
import 'design_system/components/cocktail_button.dart';
import 'design_system/components/cocktail_card.dart';
import 'design_system/components/cocktail_badge.dart';
import 'design_system/components/cocktail_background.dart';

void main() {
  runApp(const StorybookApp());
}

class StorybookApp extends StatelessWidget {
  const StorybookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Storybook(
      initialStory: 'CocktailButton',
      wrapperBuilder: (context, child) => MaterialApp(
        theme: CocktailTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true, // 이 줄이 있어야 storybook_flutter의 디바이스 프레임이 정상 동작할 수 있습니다.
        home: Scaffold(
          body: CocktailBackground(
            child: Center(child: child),
          ),
        ),
      ),
      stories: [
        Story(
          name: 'Components/CocktailButton/Primary',
          description: '기본 포인트 색상의 메인 버튼입니다.',
          builder: (context) => CocktailButton(
            text: '레시피 저장하기',
            icon: Icons.favorite,
            isPrimary: true,
            onPressed: () {},
          ),
        ),
        Story(
          name: 'Components/CocktailButton/Secondary',
          description: '눈에 덜 띄어야 하는 보조 버튼입니다.',
          builder: (context) => CocktailButton(
            text: '취소',
            isPrimary: false,
            onPressed: () {},
          ),
        ),
        Story(
          name: 'Components/CocktailCard',
          description: '목록이나 상세 화면에서 아이템을 담을 둥근 카드입니다.',
          builder: (context) => const Padding(
            padding: EdgeInsets.all(16.0),
            child: CocktailCard(
              child: SizedBox(
                width: 200,
                height: 100,
                child: Center(
                  child: Text('따뜻한 카드 레이아웃'),
                ),
              ),
            ),
          ),
        ),
        Story(
          name: 'Components/CocktailBadge',
          description: '라벨이나 알코올 기주 등 작은 키워드를 표시하는 칩입니다.',
          builder: (context) => const CocktailBadge(
            label: '위스키 베이스',
            icon: Icons.liquor,
          ),
        ),
      ],
    );
  }
}
