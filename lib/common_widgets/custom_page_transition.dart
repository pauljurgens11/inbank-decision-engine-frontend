import 'package:flutter/material.dart';

/// CustomPageTransition class is an override of the usual page transition.
///
/// This enables us to create a custom transition, where the pages move vertically.
class CustomPageTransition extends PageRouteBuilder {
  /// Page that is the desired destination of the transition.
  final Widget enterPage;

  /// Page that the user was on before initiating the transition.
  final Widget exitPage;

  /// Whether the next page is positioned down from the current page or not.
  final bool isNextPageDown;

  /// Override the usual transition duration.
  @override
  Duration get transitionDuration => const Duration(milliseconds: 1000);

  /// Custom page transition.
  @override
  CustomPageTransition(
      {required this.exitPage,
      required this.enterPage,
      required this.isNextPageDown})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              enterPage,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              Stack(
            children: <Widget>[
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 0.0),
                  end: isNextPageDown
                      ? const Offset(0.0, -1.0)
                      : const Offset(0.0, 1.0),
                ).chain(CurveTween(curve: Curves.easeInOut)).animate(animation),
                child: exitPage,
              ),
              SlideTransition(
                position: Tween<Offset>(
                  begin: isNextPageDown
                      ? const Offset(0.0, 1.0)
                      : const Offset(0.0, -1.0),
                  end: Offset.zero,
                ).chain(CurveTween(curve: Curves.easeInOut)).animate(animation),
                child: enterPage,
              )
            ],
          ),
        );
}
