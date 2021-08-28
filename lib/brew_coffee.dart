import 'package:flutter/material.dart';

class BrewCoffeePage extends StatelessWidget {
  const BrewCoffeePage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => const BrewCoffeePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Brew'),
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      ),
    );
  }
}
