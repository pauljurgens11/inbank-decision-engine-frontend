import 'package:decisionengine_frontend/decision_engine_application.dart';
import 'package:decisionengine_frontend/pages/title_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Application', () {
    testWidgets('should switch theme', (tester) async {
      await tester.pumpWidget(const Application());
      final ApplicationState applicationState =
          tester.state<ApplicationState>(find.byType(Application));

      expect(false, applicationState.isCurrentThemeDark());

      applicationState.changeTheme();
      await tester.pump();
      expect(true, applicationState.isCurrentThemeDark());

      applicationState.changeTheme();
      await tester.pump();
      expect(false, applicationState.isCurrentThemeDark());
    });

    testWidgets('initial page should be TitlePage',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: Application()));
      expect(find.byType(TitlePage), findsOneWidget);
    });
  });
}
