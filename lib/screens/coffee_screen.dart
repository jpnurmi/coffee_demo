import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizard_router/wizard_router.dart';

import '../constants.dart';

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
                onPressed: Wizard.of(context).next,
                child: const Text('NEXT >'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CoffeeModel extends ChangeNotifier {
  CoffeeModel(String who, String what)
      : _who = ValueNotifier(who),
        _what = ValueNotifier(what) {
    _who.addListener(notifyListeners);
    _what.addListener(notifyListeners);
  }

  final ValueNotifier<String> _who;
  final ValueNotifier<String> _what;

  String get who => _who.value;
  set who(String who) => _who.value = who;

  String get what => _what.value;
  set what(String what) => _what.value = what;
}
