import 'dart:async';

import 'package:flutter/foundation.dart';

import '../service.dart';

const kInterval = Duration(seconds: 5);

class BrewModel extends ChangeNotifier {
  BrewModel(this._service, this._count) : assert(_count > 0);

  final Service _service;
  final int _count;
  var _current = 0;
  Timer? _timer;
  late ValueChanged<int> _onSlide;
  late VoidCallback _onSuccess;
  late VoidCallback _onFailure;

  int get slide => _current;

  int setSlide(int current) {
    if (_current == current) return _current;
    _restartTimer();
    _current = current % _count;
    _onSlide.call(_current);
    notifyListeners();
    return _current;
  }

  void init({
    required ValueChanged<int> onSlide,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) {
    _restartTimer();
    _onSlide = onSlide;
    _onSuccess = onSuccess;
    _onFailure = onFailure;
  }

  bool get hasNext => _current < _count - 1;
  int next() => setSlide(_current + 1);

  bool get hasPrevious => _current > 0;
  int previous() => setSlide(_current - 1);

  void _restartTimer() {
    _timer?.cancel();
    if (_current <= _count - 1) {
      _timer = Timer.periodic(kInterval, (_) {
        if (next() >= _count - 1) {
          _timer?.cancel();
        }
      });
    }
  }

  var _busy = false;
  bool get isBusy => _busy;
  void _setBusy(bool busy) {
    if (_busy == busy) return;
    _busy = busy;
    notifyListeners();
  }

  Future<void> makeCoffee() async {
    _setBusy(true);
    final ok = await _service.makeCoffee();
    if (ok) {
      _onSuccess();
    } else {
      _onFailure();
    }
    _setBusy(false);
  }
}
