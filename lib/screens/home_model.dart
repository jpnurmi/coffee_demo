import 'dart:async';

import 'package:flutter/foundation.dart';

const kInterval = Duration(seconds: 2);

class HomeModel extends ChangeNotifier {
  HomeModel(this._count);

  int _index = 0;
  final int _count;
  late Timer _timer;

  int get index => _index;

  void next() {
    _index = (_index + 1) % _count;
    notifyListeners();
  }

  void init() => _timer = Timer.periodic(kInterval, (_) => next());

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
