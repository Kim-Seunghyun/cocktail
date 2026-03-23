import 'package:flutter/material.dart';
import '../models/cocktail.dart';
import 'cocktail_list_screen.dart';
import 'add_recipe_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BaseLiquor? _selectedLiquor;

  @override
  Widget build(BuildContext context) {
    const liquors = BaseLiquor.values;

    return Scaffold(
      appBar: AppBar(
        title: const Text('칵테일 레시피'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '카테고리 선택',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<BaseLiquor>(
                  isExpanded: true,
                  hint: const Text('기주(Base Liquor)를 선택해주세요'),
                  value: _selectedLiquor,
                  items: liquors.map((liquor) {
                    return DropdownMenuItem(
                      value: liquor,
                      child: Text(liquor.displayName),
                    );
                  }).toList(),
                  onChanged: (BaseLiquor? value) {
                    if (value != null) {
                      setState(() {
                        _selectedLiquor = value;
                      });
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: _selectedLiquor == null
                  ? const Center(
                      child: Text(
                        '기주를 선택하시면\n관련 칵테일 레시피를 보여드려요.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          '${_selectedLiquor!.displayName} 베이스 칵테일',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: CocktailListScreen(baseLiquor: _selectedLiquor!),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddRecipeScreen(),
            ),
          );
        },
        tooltip: '레시피 추가',
        child: const Icon(Icons.add),
      ),
    );
  }
}
