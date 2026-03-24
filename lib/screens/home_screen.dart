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
  CocktailColor? _selectedColor;
  List<CocktailTaste> _selectedTastes = [];
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearchFocused = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      setState(() {
        _isSearchFocused = _searchFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  bool get _isFilterActive =>
      _selectedLiquor != null ||
      _selectedColor != null ||
      _selectedTastes.isNotEmpty ||
      _searchQuery.isNotEmpty;

  void _clearFilters() {
    setState(() {
      _selectedLiquor = null;
      _selectedColor = null;
      _selectedTastes.clear();
      _searchController.clear();
      _searchQuery = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    const liquors = BaseLiquor.values;

    return Scaffold(
      appBar: AppBar(
        title: const Text('칵테일 레시피'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (_isFilterActive)
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: '필터 초기화',
              onPressed: _clearFilters,
            )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 재료 검색
            TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              decoration: InputDecoration(
                hintText: '재료 이름으로 검색 (예: 레몬, 토닉)',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 16),
            
            if (_isSearchFocused || _selectedColor != null || _selectedTastes.isNotEmpty) ...[
              // 색상 필터
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '색상으로 찾기',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  if (_isSearchFocused && _selectedColor == null && _selectedTastes.isEmpty)
                    TextButton(
                      onPressed: () {
                        _searchFocusNode.unfocus();
                      },
                      child: const Text('닫기', style: TextStyle(fontSize: 12)),
                    )
                ],
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: CocktailColor.values.map((color) {
                    final isSelected = _selectedColor == color;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = isSelected ? null : color;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? Colors.deepPurple : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: color.displayColor,
                          child: isSelected
                              ? Icon(Icons.check, color: color == CocktailColor.clear ? Colors.black : Colors.white, size: 20)
                              : null,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),
              
              // 맛 필터
              const Text(
                '맛으로 찾기',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: CocktailTaste.values.map((taste) {
                    final isSelected = _selectedTastes.contains(taste);
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        label: Text(taste.displayName),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedTastes.add(taste);
                            } else {
                              _selectedTastes.remove(taste);
                            }
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // 기주 선택
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
                  items: [
                    const DropdownMenuItem<BaseLiquor>(
                      value: null,
                      child: Text('기주 선택 안함 (전체)'),
                    ),
                    ...liquors.map((liquor) {
                      return DropdownMenuItem(
                        value: liquor,
                        child: Text(liquor.displayName),
                      );
                    }),
                  ],
                  onChanged: (BaseLiquor? value) {
                    setState(() {
                      _selectedLiquor = value;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),

            // 검색 결과
            Expanded(
              child: !_isFilterActive
                  ? const Center(
                      child: Text(
                        '원하는 취향이나 색상, 기주를 선택하여\n칵테일 레시피를 찾아보세요.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          '검색 결과',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: CocktailListScreen(
                            baseLiquor: _selectedLiquor,
                            color: _selectedColor,
                            tastes: _selectedTastes,
                            searchQuery: _searchQuery,
                          ),
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
