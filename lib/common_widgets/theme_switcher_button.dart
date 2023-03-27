import 'package:flutter/material.dart';

import '../decision_engine_application.dart';
import '../utils/palette.dart';

/// ThemeSwitcher class is a widget that's always visible on the screen.
///
/// This class allows the user to switch between dark and light theme modes.
class ThemeSwitcher extends StatefulWidget {
  /// Whether it's currently dark mode or not
  final bool isDarkMode;

  const ThemeSwitcher({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  State<ThemeSwitcher> createState() => ThemeSwitcherState();
}

class ThemeSwitcherState extends State<ThemeSwitcher> {
  /// Whether it's currently dark mode or not. Gets value from parent class.
  bool isDarkMode = false;

  /// Init method.
  @override
  void initState() {
    super.initState();
    isDarkMode = widget.isDarkMode;
  }

  /// Build either tab of the toggle button (one side of the button).
  ///
  /// The tab is different depending on if it's selected or not.
  Widget getTabWidget(String title, bool isTabSelected) {
    return isTabSelected
        ? Text(title, style: Palette.inriaSansStyle(color: Palette.lightGray))
        : Container(
            width: 80.0,
            height: 40.0,
            color: Palette.lightGray,
            child: Center(child: Text(title, style: Palette.inriaSansStyle())));
  }

  /// Build a custom toggle button.
  Widget customToggleButton() {
    return ToggleButtons(
      direction: Axis.horizontal,
      onPressed: (int index) {
        setState(() {
          if ((index == 0 && isDarkMode == true) ||
              (index == 1 && isDarkMode == false)) {
            Application.of(context).changeTheme();
            isDarkMode = !isDarkMode;
          }
        });
      },
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      selectedBorderColor: Palette.accentColor,
      selectedColor: Theme.of(context).cardColor,
      fillColor: Palette.accentColor.withOpacity(0.7),
      constraints: const BoxConstraints(
        minHeight: 40.0,
        minWidth: 80.0,
      ),
      isSelected: <bool>[!isDarkMode, isDarkMode],
      children: <Widget>[
        getTabWidget('Light', !isDarkMode),
        getTabWidget('Dark', isDarkMode)
      ],
    );
  }

  /// Build method.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Align(
        alignment: Alignment.topRight,
        child: customToggleButton(),
      ),
    );
  }
}
