import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../constants.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => const ResultScreen();

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), () {
      //Navigator.of(context).popUntil((route) => route.isFirst);
    });
  }

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
            Html(
              data: '<a>juju.is/brew</a>',
              style: {'body': Style(fontSize: FontSize.larger)},
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
