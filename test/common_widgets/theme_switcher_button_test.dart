import 'package:decisionengine_frontend/common_widgets/theme_switcher_button.dart';
import 'package:decisionengine_frontend/decision_engine_application.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ThemeSwitcher', () {
    testWidgets('initially dark mode should be off', (tester) async {
      await tester.pumpWidget(const Application());
      final ThemeSwitcherState themeSwitcherState =
          tester.state<ThemeSwitcherState>(find.byType(ThemeSwitcher));

      expect(false, themeSwitcherState.isDarkMode);
    });

    testWidgets('should switch theme when button is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(const Application());
      final ThemeSwitcherState themeSwitcherState =
          tester.state<ThemeSwitcherState>(find.byType(ThemeSwitcher));
      final ApplicationState applicationState =
          tester.state<ApplicationState>(find.byType(Application));

      await tester.tap(find.text('Dark'));
      expect(true, themeSwitcherState.isDarkMode);
      expect(true, applicationState.isCurrentThemeDark());

      await tester.tap(find.text('Dark'));
      expect(true, themeSwitcherState.isDarkMode);
      expect(true, applicationState.isCurrentThemeDark());

      await tester.tap(find.text('Light'));
      expect(false, themeSwitcherState.isDarkMode);
      expect(false, applicationState.isCurrentThemeDark());
    });
  });
}
