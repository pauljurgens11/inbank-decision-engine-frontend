import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// The Palette class contains the application's colors and text styles.
class Palette {
  /// Colors accessible from the Palette class
  static const accentColor = Color(0xFFAF72CB);
  static const secondaryAccentColor = Color(0xFFE7C723);

  static const black = Color(0xFF000000);
  static const lightGray = Color(0xFFF9F9F9);
  static const darkGray = Color(0xFF686868);
  static const transparent = Color(0x00FFFFFF);

  /// Colors accessible from ThemeData.of(context);
  ///
  /// These colors change when switching between light and dark themes.
  static const _backgroundColorLight = Color(0xFFE8E8E8);
  static const _backgroundColorDark = Color(0xFF404040);

  static const _primaryTextColorLight = Color(0xFF2E2E2E);
  static const _primaryTextColorDark = Color(0xFFF0F0F0);
  static const _secondaryTextColorLight = Color(0xFF606060);
  static const _secondaryTextColorDark = Color(0xFFAEAEAE);

  static const _whiteColorLight = Color(0xFFF9F9F9);
  static const _whiteColorDark = Color(0xFFD9D9D9);

  static const _errorColorLight = Color(0xFFF44336);
  static const _errorColorDark = Color(0xFFFF9a91);

  /// Light theme of the app
  static ThemeData lightTheme = ThemeData(
      backgroundColor: _backgroundColorLight,
      textTheme: TextTheme(
        headline1:
            inriaSerifStyle(fontSize: 108.0, color: _primaryTextColorLight),
        headline2:
            inriaSerifStyle(fontSize: 42.0, color: _primaryTextColorLight),
        bodyText2: inriaSansStyle(color: _secondaryTextColorLight),
      ),
      errorColor: _errorColorLight,
      cardColor: _whiteColorLight);

  /// Dark theme of the app
  static ThemeData darkTheme = ThemeData(
      backgroundColor: _backgroundColorDark,
      textTheme: TextTheme(
        headline1:
            inriaSerifStyle(fontSize: 108.0, color: _primaryTextColorDark),
        headline2:
            inriaSerifStyle(fontSize: 42.0, color: _primaryTextColorDark),
        bodyText1: inriaSansStyle(color: _secondaryTextColorDark),
      ),
      errorColor: _errorColorDark,
      cardColor: _whiteColorDark);

  /// Common font styles – Serif is used more for headings, while sans more for paragraphs
  static var inriaSerifStyle =
      ({fontSize, color = Palette.black, fontWeight}) => GoogleFonts.inriaSerif(
          color: color, fontSize: fontSize, fontWeight: fontWeight);

  static var inriaSansStyle = ({fontSize, color = Palette.black, fontWeight}) =>
      GoogleFonts.inriaSans(
          color: color, fontSize: fontSize, fontWeight: fontWeight);
}
