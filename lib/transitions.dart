import 'package:flutter/material.dart';

class SlideTransitionsBuilder extends PageTransitionsBuilder {
  const SlideTransitionsBuilder();
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    animation = CurvedAnimation(curve: Curves.easeInOut, parent: animation);
    return SlideTransition(
      position:
          Tween(begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
              .animate(animation),
      child: child,
    );
  }
}
