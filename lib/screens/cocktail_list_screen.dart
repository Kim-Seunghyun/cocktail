import 'package:flutter/material.dart';
import '../models/cocktail.dart';
import '../data/mock_data.dart';
import 'cocktail_detail_screen.dart';

class CocktailListScreen extends StatefulWidget {
  final BaseLiquor? baseLiquor;
  final String? searchQuery;
  final CocktailColor? color;
  final List<CocktailTaste> tastes;

  const CocktailListScreen({
    super.key,
    this.baseLiquor,
    this.searchQuery,
    this.color,
    this.tastes = const [],
  });

  @override
  State<CocktailListScreen> createState() => _CocktailListScreenState();
}

class _CocktailListScreenState extends State<CocktailListScreen> {
  @override
  Widget build(BuildContext context) {
    // 모든 필터 적용하여 목록 가져오기
    final List<Cocktail> cocktails = MockData.search(
      baseLiquor: widget.baseLiquor,
      color: widget.color,
      tastes: widget.tastes,
      keyword: widget.searchQuery,
    );
    
    // 기주만 단독으로 검색된 상태인지 확인 (재정렬용)
    final bool canReorder = widget.baseLiquor != null &&
        (widget.searchQuery == null || widget.searchQuery!.trim().isEmpty) &&
        widget.color == null &&
        widget.tastes.isEmpty;

    if (cocktails.isEmpty) {
      return const Center(
        child: Text(
          '조건에 맞는 칵테일이 없어요.\n다른 필터를 적용해 보세요!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    Widget buildListItem(Cocktail cocktail) {
      return Container(
        key: ValueKey(cocktail.id),
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
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: cocktail.color.displayColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.withOpacity(0.5)),
            ),
            child: Icon(
              Icons.local_bar, 
              color: cocktail.color == CocktailColor.clear ? Colors.black54 : Colors.white,
            ),
          ),
          title: Text(cocktail.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cocktail.ingredients.map((e) => '${e.name} ${e.amount}').join(', ')),
              const SizedBox(height: 4),
              Wrap(
                spacing: 4,
                children: cocktail.tastes.map((t) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(t.displayName, style: const TextStyle(fontSize: 10, color: Colors.deepPurple)),
                )).toList(),
              ),
              const SizedBox(height: 4),
            ],
          ),
          isThreeLine: true,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CocktailDetailScreen(cocktail: cocktail),
              ),
            );
          },
        ),
      );
    }

    if (!canReorder) {
      // 다중 필터 모드일 때는 재정렬 및 스와이프 삭제 비활성화
      return ListView.builder(
        itemCount: cocktails.length,
        itemBuilder: (context, index) {
          return buildListItem(cocktails[index]);
        },
      );
    } else {
      // 기주별 단독 목록일 때는 기존처럼 재정렬 및 스와이프 삭제 활성화
      return ReorderableListView.builder(
        itemCount: cocktails.length,
        onReorder: (oldIndex, newIndex) {
          setState(() {
            MockData.reorderCocktails(widget.baseLiquor!, oldIndex, newIndex);
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
            child: buildListItem(cocktail),
          );
        },
      );
    }
  }
}
