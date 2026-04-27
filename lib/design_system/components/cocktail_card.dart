import 'package:flutter/material.dart';
import '../cocktail_colors.dart';

class CocktailCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  const CocktailCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CocktailColors.surface,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            color: CocktailColors.softShadow,
            blurRadius: 12,
            offset: Offset(0, 4),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.0),
          highlightColor: CocktailColors.primary.withAlpha(30),
          splashColor: CocktailColors.accent.withAlpha(30),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
