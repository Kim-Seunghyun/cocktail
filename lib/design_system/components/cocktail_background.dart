import 'package:flutter/material.dart';
import '../cocktail_colors.dart';

class CocktailBackground extends StatelessWidget {
  final Widget child;

  const CocktailBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        // 기본 배경색 바탕
        color: CocktailColors.background,
        // 은은한 모래알/가죽 질감을 주기 위한 그라데이션 (추후 noise.png 에셋으로 대체 가능)
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.5,
          colors: [
            Color(0xFF261919), // 가운데는 약간 더 밝게 조명을 받은 것처럼
            CocktailColors.background,
          ],
        ),
      ),
      child: child,
    );
  }
}
