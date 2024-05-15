import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_info/screen/news/news_screen.dart';
import 'package:news_info/screen/news/provider/news_provider.dart';
import 'package:provider/provider.dart';

void main() {
  group('News screen UI test', () {


    testWidgets('Verify CircularProgressIndicator while loading',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (context) => NewsProvider(),
            child: const NewsScreen(),
          ),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsWidgets);
      await tester.pump(const Duration(seconds: 1));
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('Verify FloatingActionButton tooltip', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (context) => NewsProvider(),
            child: const NewsScreen(),
          ),
        ),
      );

      expect(find.byTooltip('ChatBot'), findsOneWidget);
    });
  });
}