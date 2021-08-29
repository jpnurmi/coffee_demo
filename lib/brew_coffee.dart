import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api.dart';
import 'constants.dart';

class BrewCoffeePage extends StatelessWidget {
  const BrewCoffeePage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    final api = Provider.of<Api>(context, listen: false);
    return ChangeNotifierProvider(
      create: (_) => BrewCoffeeModel(api),
      child: const BrewCoffeePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: ElevatedButtonTheme(
          data: _createButtonTheme(context),
          child: _createButton(context),
        ),
      ),
    );
  }

  ElevatedButtonThemeData _createButtonTheme(BuildContext context) {
    final style = ElevatedButtonTheme.of(context).style;
    return ElevatedButtonThemeData(
      style: style?.copyWith(
        minimumSize: MaterialStateProperty.all(const Size(240, 60)),
        padding: MaterialStateProperty.all(const EdgeInsets.all(kPadding)),
        textStyle:
            MaterialStateProperty.all(Theme.of(context).textTheme.headline5),
      ),
    );
  }

  static Widget _createButton(BuildContext context) {
    final model = Provider.of<BrewCoffeeModel>(context);
    switch (model.value) {
      case BrewCoffeeState.ready:
        return ElevatedButton(
          child: const Text('Brew'),
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
          ),
          onPressed: model.brew,
        );
      case BrewCoffeeState.brewing:
        return ElevatedButton.icon(
          icon: const CircularProgressIndicator(),
          label: const Text('Brewing...'),
          onPressed: null,
        );
      case BrewCoffeeState.success:
        return ElevatedButton(
          child: const Text('Success'),
          onPressed: () => _restart(context),
        );
      case BrewCoffeeState.failure:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).errorColor,
          ),
          child: const Text('Failure'),
          onPressed: () => _restart(context),
        );
      default:
        throw UnimplementedError();
    }
  }

  static void _restart(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}

enum BrewCoffeeState {
  ready,
  brewing,
  canceled,
  success,
  failure,
}

class BrewCoffeeModel extends ValueNotifier<BrewCoffeeState> {
  BrewCoffeeModel(this._api) : super(BrewCoffeeState.ready);

  final Api _api;

  bool get isBrewing => value == BrewCoffeeState.brewing;
  bool get isSuccess => value == BrewCoffeeState.success;
  bool get isFailure => value == BrewCoffeeState.failure;

  Future<void> brew() => _cancel().then((_) => _request());

  Future<void> _cancel() {
    return _api.cancel().then((_) => value = BrewCoffeeState.canceled);
  }

  Future<void> _request() {
    value = BrewCoffeeState.brewing;
    return _api.request().then((result) {
      value = result ? BrewCoffeeState.success : BrewCoffeeState.failure;
    });
  }
}
