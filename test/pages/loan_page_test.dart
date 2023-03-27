import 'package:decisionengine_frontend/decision_engine_application.dart';
import 'package:decisionengine_frontend/pages/loan_page.dart';
import 'package:decisionengine_frontend/pages/title_page.dart';
import 'package:decisionengine_frontend/pages/widgets/loan_page_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoanPage', () {
    late Widget testWidget;

    setUp(() {
      testWidget = const MaterialApp(
        home: LoanPage(),
      );
    });

    testWidgets('should transition to title page', (tester) async {
      await tester.pumpWidget(const Application());

      await tester.tap(find.byType(Icon));
      await tester.pumpAndSettle();

      expect(find.byType(TitlePage), findsOneWidget);
    });

    testWidgets('should display loan page form', (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);
      expect(find.byType(LoanPageForm), findsOneWidget);
    });

    testWidgets('should display submit button', (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);
      expect(find.text('Submit'), findsOneWidget);
    });

    testWidgets('should disable submit button when form is invalid',
        (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);
      expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).enabled,
          isFalse);
    });

    testWidgets('should enable submit button when form is valid',
        (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);
      await tester.enterText(find.byType(TextField).first, '99999999999');
      await tester.enterText(find.byType(TextField).at(1), '5000');
      await tester.enterText(find.byType(TextField).at(2), '40');
      await tester.pump();
      expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).enabled,
          isTrue);
    });

    testWidgets('should return response after submit',
        (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);
      await tester.enterText(find.byType(TextFormField).first, '99999999999');
      await tester.enterText(find.byType(TextFormField).at(1), '5000');
      await tester.enterText(find.byType(TextFormField).at(2), '40');
      await tester.tap(find.text('Submit'));

      LoanPageState.response?.then((value) {
        expect('response', value.containsKey('response'));
      });
    });
  });
}
