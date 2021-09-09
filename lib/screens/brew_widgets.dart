import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BrewSlide extends StatelessWidget {
  const BrewSlide(this.label, {Key? key}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        label,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}

// https://flutter.dev/docs/release/breaking-changes/default-scroll-behavior-drag#setting-a-custom-scrollbehavior-for-your-application
class MouseDragScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
