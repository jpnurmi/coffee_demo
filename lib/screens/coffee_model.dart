import 'package:flutter/foundation.dart';

import '../service.dart';

enum Coffee {
  latte,
  black,
  cappuccino,
  tea,
}

extension CoffeeType on Coffee {
  String get type {
    switch (this) {
      case Coffee.latte:
        return 'LAT';
      case Coffee.black:
        return 'BCK';
      case Coffee.cappuccino:
        return 'CAP';
      case Coffee.tea:
        return 'TEA';
    }
  }
}

class CoffeeModel extends ChangeNotifier {
  CoffeeModel(this._service, String user, Coffee coffee)
      : _user = ValueNotifier(user),
        _coffee = ValueNotifier(coffee) {
    _user.addListener(notifyListeners);
    _coffee.addListener(notifyListeners);
  }

  final Service _service;
  final ValueNotifier<String> _user;
  final ValueNotifier<Coffee> _coffee;
  late final VoidCallback _onSuccess;
  late final VoidCallback _onFailure;
  var _busy = false;

  void init({
    required VoidCallback onFailure,
    required VoidCallback onSuccess,
  }) {
    _onFailure = onFailure;
    _onSuccess = onSuccess;
  }

  String get user => _user.value;
  set user(String user) => _user.value = user;

  Coffee get coffee => _coffee.value;
  set coffee(Coffee coffee) => _coffee.value = coffee;

  bool get isBusy => _busy;
  void _setBusy(bool busy) {
    if (_busy == busy) return;
    _busy = busy;
    notifyListeners();
  }

  Future<void> selectCoffee() async {
    _setBusy(true);
    final ok = await _service.healthCheck();
    if (ok) {
      _service.selectCoffee(coffee.type);
      _onSuccess();
    } else {
      _onFailure();
    }
    _setBusy(false);
  }
}
