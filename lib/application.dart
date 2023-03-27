import 'package:decisionengine_frontend/common_widgets/circles_background.dart';
import 'package:decisionengine_frontend/common_widgets/custom_page_transition.dart';
import 'package:decisionengine_frontend/pages/loan_page.dart';
import 'package:decisionengine_frontend/utils/palette.dart';
import 'package:flutter/material.dart';

import 'common_widgets/theme_switcher_button.dart';
import 'pages/title_page.dart';

/// Application class.
///
/// This is the parent of all other classes (with the exception of utils).
/// This class in particular builds elements that are always on the screen, no
/// matter what page the user is on. Also, it sets up theme switching and navigation.
class Application extends StatefulWidget {
  const Application({super.key});

  @override
  ApplicationState createState() => ApplicationState();

  /// This makes ApplicationState's public methods accessible from child classes.
  static ApplicationState of(BuildContext context) =>
      context.findAncestorStateOfType<ApplicationState>()!;
}

class ApplicationState extends State<Application> {
  /// Current theme mode.
  ThemeMode _themeMode = ThemeMode.light;

  /// Get boolean expression that shows if the current theme is dark theme.
  bool isCurrentThemeDark() {
    return _themeMode == ThemeMode.dark;
  }

  /// Change current theme from dark to light or light to dark.
  void changeTheme() {
    setState(() {
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.light;
      }
    });
  }

  /// Custom navigator used for navigating between the title page and loan page.
  Widget _customNavigator() {
    return Navigator(
      onGenerateRoute: (settings) {
        Widget exitPage = const LoanPage();
        Widget enterPage = const TitlePage();
        bool isNextPageDown = false;

        if (settings.name == 'loanpage') {
          exitPage = const TitlePage();
          enterPage = const LoanPage();
          isNextPageDown = true;
        }
        return CustomPageTransition(
            exitPage: exitPage,
            enterPage: enterPage,
            isNextPageDown: isNextPageDown);
      },
    );
  }

  /// Build method.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Palette.lightTheme,
      darkTheme: Palette.darkTheme,
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home: Stack(children: [
        _customNavigator(),
        const ThemeSwitcher(isDarkMode: false),
        const CirclesBackground(),
      ]),
    );
  }
}
