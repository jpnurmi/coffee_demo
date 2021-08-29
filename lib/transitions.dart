import 'package:flutter/material.dart';

import 'constants.dart';

class SlideTransitionsBuilder extends PageTransitionsBuilder {
  const SlideTransitionsBuilder();
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return SlideTransition(
      position: Tween(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).chain(CurveTween(curve: kSlideCurve)).animate(animation),
      child: SlideTransition(
        position: Tween(
          begin: Offset.zero,
          end: const Offset(-1.0, 0.0),
        ).chain(CurveTween(curve: kSlideCurve)).animate(secondaryAnimation),
        child: child,
      ),
    );
  }
}
