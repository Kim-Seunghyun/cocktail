import 'package:flutter/material.dart';
import '../models/cocktail.dart';

class CocktailDetailScreen extends StatelessWidget {
  final Cocktail cocktail;

  const CocktailDetailScreen({super.key, required this.cocktail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cocktail.name),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 기본 정보 카드
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.liquor, size: 40, color: Colors.deepPurple),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '베이스: ${cocktail.baseLiquor.displayName}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 재료 섹션
              const Text(
                '재료',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ...cocktail.ingredients.map(
                (ingredient) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_outline, size: 20),
                      const SizedBox(width: 8),
                      Text('${ingredient.name} ${ingredient.amount}', style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 제조법 섹션
              const Text(
                '제조 방법',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  cocktail.instructions,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
