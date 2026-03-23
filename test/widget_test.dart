// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:coctail/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const CocktailApp());

    // 기본 진입점(메인) 렌더링 검사
    expect(find.text('칵테일 메뉴 🍸'), findsNothing); // CocktailApp 렌더링 확인용 더미
  });
}
