import 'package:flutter/material.dart';

import '../constants.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => const ResultScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Enjoy your free coffee and software!',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: kSpacing * 3),
            Text(
              'jusu.is/brew',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
