import 'package:flutter/foundation.dart';

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
