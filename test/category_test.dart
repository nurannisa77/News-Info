import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_info/screen/category/widget/category_search_widget.dart';
import 'package:provider/provider.dart';
import 'package:news_info/screen/category/provider/category_provider.dart';

void main() {
  testWidgets('CategorySearchWidget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<CategoryProvider>(
          create: (_) => CategoryProvider(),
          child: const Scaffold(
            body: CategorySearchWidget(),
          ),
        ),
      ),
    );

  
    final textFieldFinder = find.byType(TextField);
    expect(textFieldFinder, findsOneWidget);
    await tester.enterText(textFieldFinder, 'Test query');
  });
}