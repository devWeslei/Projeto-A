import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SearchButton Test', (WidgetTester tester) async {
    bool isButtonClicked = false;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff334bea),
              padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
            ),
            onPressed: () {
              isButtonClicked = true;
            },
            child: const Text(
              "Pesquisar",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    ));

    await tester.tap(find.byType(ElevatedButton));

    await tester.pump();

    expect(isButtonClicked, true);
  });
}
