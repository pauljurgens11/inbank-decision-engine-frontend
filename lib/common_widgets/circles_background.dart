import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// CirclesBackground class is a widget that's always visible on the screen.
///
/// It displays a pleasing visual design consisting of 3 circles in the bottom
/// right corner of the screen.
class CirclesBackground extends StatelessWidget {
  const CirclesBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: SvgPicture.asset(
        "transparent_circles.svg",
      ),
    );
  }
}
