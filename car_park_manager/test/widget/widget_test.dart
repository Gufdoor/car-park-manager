import 'package:car_park_manager/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("FormFields", () {
    testWidgets("When setting vacancies then is expected that the input text is saved in a controller", (tester) async {
      // arrange
      final vacanciesField = find.byKey(const ValueKey("vacancies"));
      final vacanciesButton = find.byKey(const ValueKey("setVacancies"));

      // act
      await tester.pumpWidget(const MainApp());
      await tester.enterText(vacanciesField, "10");
      await tester.tap(vacanciesButton);
      await tester.pump();

      // assert
      expect(find.text("10"), findsOneWidget);
    });

    testWidgets("When setting licensePlate then is expected that the input text is saved in a controller", (tester) async {
      // arrange
      final licensePlateField = find.byKey(const ValueKey("licensePlate"));
      final licensePlateButton = find.byKey(const ValueKey("setLicensePlate"));

      // act
      await tester.pumpWidget(MaterialApp(home: Container()));
      await tester.enterText(licensePlateField, "abc1234");
      await tester.tap(licensePlateButton);
      await tester.pump();

      // assert
      expect(find.text("abc1234"), findsOneWidget);
    });
  });
}
