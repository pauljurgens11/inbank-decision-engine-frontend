import 'package:decisionengine_frontend/decision_engine_application.dart';
import 'package:decisionengine_frontend/pages/loan_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TitlePage', () {
    testWidgets('should transition to loan page', (tester) async {
      await tester.pumpWidget(const Application());

      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      expect(find.byType(LoanPage), findsOneWidget);
    });
  });
}
