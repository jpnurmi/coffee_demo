import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api.dart';
import '../constants.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    final api = Provider.of<Api>(context, listen: false);
    return ChangeNotifierProvider(
      create: (_) => ResultModel(api),
      child: const ResultScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    final model = Provider.of<ResultModel>(context);
    switch (model.value) {
      case ResultScreenState.ready:
        return ElevatedButton(
          child: const Text('Brew'),
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
          ),
          onPressed: model.brew,
        );
      case ResultScreenState.brewing:
        return ElevatedButton.icon(
          icon: const CircularProgressIndicator(),
          label: const Text('Brewing...'),
          onPressed: null,
        );
      case ResultScreenState.success:
        return ElevatedButton(
          child: const Text('Success'),
          onPressed: () => _restart(context),
        );
      case ResultScreenState.failure:
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

enum ResultScreenState {
  ready,
  brewing,
  canceled,
  success,
  failure,
}

class ResultModel extends ValueNotifier<ResultScreenState> {
  ResultModel(this._api) : super(ResultScreenState.ready);

  final Api _api;

  bool get isBrewing => value == ResultScreenState.brewing;
  bool get isSuccess => value == ResultScreenState.success;
  bool get isFailure => value == ResultScreenState.failure;

  Future<void> brew() => _cancel().then((_) => _request());

  Future<void> _cancel() {
    return _api.cancel().then((_) => value = ResultScreenState.canceled);
  }

  Future<void> _request() {
    value = ResultScreenState.brewing;
    return _api.request().then((result) {
      value = result ? ResultScreenState.success : ResultScreenState.failure;
    });
  }
}
