import 'package:decisionengine_frontend/decision_engine_application.dart';
import 'package:decisionengine_frontend/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoanPageForm', () {
    testWidgets('should display the form correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const Application());

      expect(find.text('Personal code:'), findsOneWidget);
      expect(find.text('Loan amount:'), findsOneWidget);
      expect(find.text('Loan period:'), findsOneWidget);
      expect(find.byType(Slider), findsNWidgets(2));
      expect(find.byType(TextFormField), findsNWidgets(3));
    });

    testWidgets('should validate the form correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const Application());

      // Check that the form is initially invalid
      expect(find.text('Enter a code with 11 digits.'), findsNothing);
      expect(find.text('Enter a loan amount.'), findsNothing);
      expect(find.text('Enter a loan period.'), findsNothing);

      // Enter invalid personal code
      await tester.enterText(find.byType(TextFormField).at(0), '123');
      await tester.pumpAndSettle();

      expect(find.text('Enter a code with 11 digits.'), findsOneWidget);

      // Enter valid personal code
      await tester.enterText(find.byType(TextFormField).at(0), '12345678901');
      await tester.pumpAndSettle();

      expect(find.text('Enter a code with 11 digits.'), findsNothing);

      // Enter valid loan amount
      await tester.enterText(find.byType(TextFormField).at(1), '300');
      await tester.enterText(find.byType(TextFormField).at(2), '11');
      await tester.pumpAndSettle();

      expect(
          find.text(
              'Between ${Constants.loanAmountMinValue} and ${Constants.loanAmountMaxValue}.'),
          findsOneWidget);
      expect(
          find.text(
              'Between ${Constants.loanPeriodMinValue} and ${Constants.loanPeriodMaxValue}.'),
          findsOneWidget);

      // Enter valid loan period
      await tester.enterText(find.byType(TextFormField).at(1), '3000');
      await tester.enterText(find.byType(TextFormField).at(2), '15');
      await tester.pumpAndSettle();

      expect(
          find.text(
              'Between ${Constants.loanAmountMinValue} and ${Constants.loanAmountMaxValue}.'),
          findsNothing);
      expect(
          find.text(
              'Between ${Constants.loanPeriodMinValue} and ${Constants.loanPeriodMaxValue}.'),
          findsNothing);
    });
  });
}
