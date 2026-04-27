import 'package:flutter/material.dart';
import '../models/cocktail.dart';
import '../data/mock_data.dart';

class _IngredientInput {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  void dispose() {
    nameController.dispose();
    amountController.dispose();
  }
}

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  // Form의 상태를 관리하고 검증(validation)하기 위한 키
  final _formKey = GlobalKey<FormState>();

  // 사용자가 입력한 값을 저장할 변수들
  String _name = '';
  BaseLiquor _baseLiquor = BaseLiquor.whiskey;
  CocktailColor _color = CocktailColor.clear;
  final List<CocktailTaste> _tastes = [];
  String _instructions = '';

  final List<_IngredientInput> _ingredientInputs = [_IngredientInput()];

  @override
  void dispose() {
    for (var input in _ingredientInputs) {
      input.dispose();
    }
    super.dispose();
  }

  void _saveRecipe() {
    // 폼의 모든 필드가 규칙(validator)을 통과했는지 확인
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // 재료 리스트 생성
      final ingredientList = _ingredientInputs
          .where((input) => input.nameController.text.trim().isNotEmpty)
          .map((input) => RecipeIngredient(
                name: input.nameController.text.trim(),
                amount: input.amountController.text.trim(),
              ))
          .toList();

      if (ingredientList.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('재료를 1개 이상 입력해주세요.')),
        );
        return;
      }

      // 새 칵테일 객체 생성
      final newCocktail = Cocktail(
        id: DateTime.now().toString(), // 임의의 고유 ID
        name: _name,
        baseLiquor: _baseLiquor,
        color: _color,
        tastes: List.from(_tastes),
        ingredients: ingredientList,
        instructions: _instructions,
      );

      // 데이터 저장
      MockData.addCocktail(newCocktail);

      // 사용자에게 알림 표시 및 이전 화면으로 돌아가기
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$_name 레시피가 등록되었습니다!')),
      );
      Navigator.pop(context);
    }
  }

  void _addIngredientRow() {
    setState(() {
      _ingredientInputs.add(_IngredientInput());
    });
  }

  void _removeIngredientRow(int index) {
    setState(() {
      if (_ingredientInputs.length > 1) {
        _ingredientInputs[index].dispose();
        _ingredientInputs.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('새 레시피 등록 🍸'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 칵테일 이름 입력
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '칵테일 이름',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '이름을 입력해주세요.';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              const SizedBox(height: 16),

              // 베이스 기주 선택
              DropdownButtonFormField<BaseLiquor>(
                decoration: const InputDecoration(
                  labelText: '베이스 기주',
                  border: OutlineInputBorder(),
                ),
                value: _baseLiquor,
                items: BaseLiquor.values.map((liquor) {
                  return DropdownMenuItem(
                    value: liquor,
                    child: Text(liquor.displayName),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    if (value != null) _baseLiquor = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // 칵테일 색상 선택
              DropdownButtonFormField<CocktailColor>(
                decoration: const InputDecoration(
                  labelText: '칵테일 색상',
                  border: OutlineInputBorder(),
                ),
                value: _color,
                items: CocktailColor.values.map((color) {
                  return DropdownMenuItem(
                    value: color,
                    child: Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: color.displayColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(color.displayName),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    if (value != null) _color = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // 맛 특징 선택
              const Text(
                '맛 특징 (다중 선택 가능)',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: CocktailTaste.values.map((taste) {
                  final isSelected = _tastes.contains(taste);
                  return FilterChip(
                    label: Text(taste.displayName),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _tastes.add(taste);
                        } else {
                          _tastes.remove(taste);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // 재료 입력 (동적 리스트)
              const Text(
                '재료 입력',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ..._ingredientInputs.asMap().entries.map((entry) {
                final index = entry.key;
                final input = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          controller: input.nameController,
                          decoration: const InputDecoration(
                            labelText: '재료명 (예: 진)',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          validator: (value) {
                            if (index == 0 &&
                                (value == null || value.trim().isEmpty)) {
                              return '필수';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: input.amountController,
                          decoration: const InputDecoration(
                            labelText: '용량 (예: 45ml)',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        color: Colors.red,
                        onPressed: _ingredientInputs.length > 1
                            ? () => _removeIngredientRow(index)
                            : null, // 첫 번째 항목은 삭제 불가
                      ),
                    ],
                  ),
                );
              }),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: _addIngredientRow,
                  icon: const Icon(Icons.add),
                  label: const Text('재료 추가'),
                ),
              ),
              const SizedBox(height: 16),

              // 제조 방법 입력
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '제조 방법',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '제조 방법을 입력해주세요.';
                  }
                  return null;
                },
                onSaved: (value) => _instructions = value!,
              ),
              const SizedBox(height: 24),

              // 저장 버튼
              ElevatedButton(
                onPressed: _saveRecipe,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('저장하기', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
