import 'package:flutter/material.dart';
import '../cocktail_colors.dart';

class CocktailBadge extends StatelessWidget {
  final String label;
  final IconData? icon;

  const CocktailBadge({
    super.key,
    required this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: CocktailColors.primary.withAlpha(50),
        border: Border.all(color: CocktailColors.accent.withAlpha(100), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: CocktailColors.accent),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: const TextStyle(
              color: CocktailColors.accent,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
