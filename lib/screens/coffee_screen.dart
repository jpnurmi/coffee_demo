import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../routes.dart';
import 'coffee_model.dart';

const kWho = <String>['SysAdmin', 'DevOps', 'CTO', 'Engineer', 'Other'];
const kWhat = <String>['latte', 'black coffee', 'cappuccino'];

class CoffeeScreen extends StatelessWidget {
  const CoffeeScreen({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CoffeeModel(kWho.first, kWhat.first),
      child: const CoffeeScreen(),
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
              Text(
                'Who are you and what kind of coffee do you like?',
                style: Theme.of(context).textTheme.headline4,
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    const Text('I am a'),
                    const SizedBox(width: kSpacing),
                    DropdownButton<String>(
                      value: model.who,
                      items: kWho
                          .map((who) => DropdownMenuItem<String>(
                              value: who, child: Text(who)))
                          .toList(),
                      onChanged: (value) => model.who = value!,
                    ),
                    const SizedBox(width: kSpacing),
                    const Text('and I would like a'),
                    const SizedBox(width: kSpacing),
                    DropdownButton<String>(
                      value: model.what,
                      items: kWhat
                          .map((what) => DropdownMenuItem<String>(
                              value: what, child: Text(what)))
                          .toList(),
                      onChanged: (value) => model.what = value!,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed(Routes.brew),
                child: const Text('NEXT >'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
