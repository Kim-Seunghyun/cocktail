import 'package:flutter/material.dart';
import '../models/cocktail.dart';
import '../data/mock_data.dart';
import 'cocktail_detail_screen.dart';

class CocktailListScreen extends StatefulWidget {
  final BaseLiquor baseLiquor;

  const CocktailListScreen({super.key, required this.baseLiquor});

  @override
  State<CocktailListScreen> createState() => _CocktailListScreenState();
}

class _CocktailListScreenState extends State<CocktailListScreen> {
  @override
  Widget build(BuildContext context) {
    // 선택된 기주에 해당하는 칵테일 목록 가져오기
    final cocktails = MockData.getCocktailsByBase(widget.baseLiquor);

    if (cocktails.isEmpty) {
      return const Center(
        child: Text(
          '아직 등록된 레시피가 없어요.\n직접 추가해 보세요!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return ReorderableListView.builder(
      itemCount: cocktails.length,
      onReorder: (oldIndex, newIndex) {
        setState(() {
          MockData.reorderCocktails(widget.baseLiquor, oldIndex, newIndex);
        });
      },
      itemBuilder: (context, index) {
        final cocktail = cocktails[index];
        return Dismissible(
          key: ValueKey(cocktail.id),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) {
            setState(() {
              MockData.deleteCocktail(cocktail.id);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${cocktail.name} 레시피가 삭제되었습니다.')),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.local_bar, color: Colors.deepPurple),
              title: Text(cocktail.name),
              subtitle: Text(cocktail.ingredients.map((e) => '${e.name} ${e.amount}').join(', ')),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CocktailDetailScreen(cocktail: cocktail),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
