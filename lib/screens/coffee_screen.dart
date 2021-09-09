import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../routes.dart';
import '../service.dart';
import 'coffee_model.dart';

const kUsers = <String>['SysAdmin', 'DevOps', 'CTO', 'Engineer', 'Other'];

extension CoffeeName on Coffee {
  String get name {
    switch (this) {
      case Coffee.latte:
        return 'Latte';
      case Coffee.black:
        return 'Black';
      case Coffee.cappuccino:
        return 'Cappuccino';
      case Coffee.tea:
        return 'Tea';
    }
  }
}

class CoffeeScreen extends StatefulWidget {
  const CoffeeScreen({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    final service = Provider.of<Service>(context, listen: false);
    return ChangeNotifierProvider(
      create: (_) => CoffeeModel(service, kUsers.first, Coffee.latte),
      child: const CoffeeScreen(),
    );
  }

  @override
  _CoffeeScreenState createState() => _CoffeeScreenState();
}

class _CoffeeScreenState extends State<CoffeeScreen> {
  @override
  void initState() {
    super.initState();

    final model = Provider.of<CoffeeModel>(context, listen: false);
    model.init(
      onSuccess: () => Navigator.of(context).pushNamed(Routes.brew),
      onFailure: (error) {
        final snackbar = SnackBar(
          content: Text(error),
          duration: const Duration(seconds: 5),
          action: SnackBarAction(
            label: 'Return home',
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CoffeeModel>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Who are you and what kind of coffee do you like?',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              const SizedBox(height: kSpacing),
              Row(
                children: <Widget>[
                  const Text('I am a'),
                  const SizedBox(width: kSpacing),
                  DropdownButton<String>(
                    value: model.user,
                    items: kUsers
                        .map((who) => DropdownMenuItem<String>(
                            value: who, child: Text(who)))
                        .toList(),
                    onChanged: (value) => model.user = value!,
                  ),
                  const SizedBox(width: kSpacing),
                  const Text('and I would like a'),
                  const SizedBox(width: kSpacing),
                  DropdownButton<Coffee>(
                    value: model.coffee,
                    items: Coffee.values
                        .map((coffee) => DropdownMenuItem<Coffee>(
                            value: coffee, child: Text(coffee.name)))
                        .toList(),
                    onChanged: (value) => model.coffee = value!,
                  ),
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: model.isBusy
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: model.selectCoffee,
                          child: const Text('NEXT >'),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
