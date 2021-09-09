import 'dart:async';

import 'package:flutter/foundation.dart';

import '../service.dart';

const kInterval = Duration(seconds: 5);

enum BrewState {
  initializing,
  ready,
  brewing,
  error,
}

class BrewModel extends ChangeNotifier {
  BrewModel(this._service, this._count) : assert(_count > 0);

  final Service _service;
  final int _count;
  var _current = 0;
  Timer? _timer;
  late ValueChanged<int> _onSlide;
  late VoidCallback _onSuccess;
  late ValueChanged<String> _onFailure;

  int get slide => _current;

  int setSlide(int current) {
    if (_current == current) return _current;
    _restartTimer();
    _current = current % _count;
    _onSlide.call(_current);
    notifyListeners();
    return _current;
  }

  var _state = BrewState.initializing;
  BrewState get state => _state;
  void _setState(BrewState state) {
    if (_state == state) return;
    _state = state;
    notifyListeners();
  }

  Future<void> init({
    required ValueChanged<int> onSlide,
    required VoidCallback onSuccess,
    required ValueChanged<String> onFailure,
  }) async {
    _restartTimer();
    _onSlide = onSlide;
    _onSuccess = onSuccess;
    _onFailure = onFailure;

    _setState(BrewState.initializing);
    final ok = await _service.healthCheck();
    if (ok) {
      _setState(BrewState.ready);
    } else {
      _setState(BrewState.error);
      onFailure(_service.error);
    }
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

  Future<void> makeCoffee() async {
    _setState(BrewState.brewing);
    final ok = await _service.makeCoffee();
    if (ok) {
      _onSuccess();
    } else {
      _onFailure(_service.error);
    }
    _setState(BrewState.ready);
  }
}
