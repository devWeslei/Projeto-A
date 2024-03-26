import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto/views/Home.dart';

void main() {
  testWidgets('SearchField test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Home(),
      ),
    ));

    await tester.enterText(find.byType(TextField), 'This is a test!');

    expect(find.text('This is a test!'), findsOneWidget);
  });
}
