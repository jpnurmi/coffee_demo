import 'package:flutter/material.dart';
import 'package:wizard_router/wizard_router.dart';

class CoffeeScreen extends StatelessWidget {
  const CoffeeScreen({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => const CoffeeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () => Wizard.of(context).next(arguments: 0),
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Center(
            child: Column(
              children: const <Widget>[Text('Coffee')],
            ),
          ),
        ),
      ),
    );
  }
}
