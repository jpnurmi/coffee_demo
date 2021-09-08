import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api.dart';
import '../constants.dart';
import '../routes.dart';

const kSlides = <String>[
  'Swipe left to know more about the open source technologies we used to build this project.',
  'Slide 2',
  'Slide 3',
];

class BrewScreen extends StatefulWidget {
  const BrewScreen({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    final api = Provider.of<Api>(context, listen: false);
    return ChangeNotifierProvider(
      create: (_) => BrewModel(api, kSlides.length),
      child: const BrewScreen(),
    );
  }

  @override
  State<BrewScreen> createState() => _BrewScreenState();
}

class _BrewScreenState extends State<BrewScreen> {
  PageController? _controller;

  @override
  void initState() {
    super.initState();

    final model = Provider.of<BrewModel>(context, listen: false);
    model.init(
      onSlide: _animateTo,
      onSuccess: () {
        _showMessage('Success!');
        Navigator.of(context).pushNamed(Routes.result);
      },
      onFailure: () {
        _showMessage('Something went wrong', Theme.of(context).errorColor);
      },
    );
  }

  void _showMessage(String message, [Color? color]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, style: TextStyle(color: color))),
    );
  }

  @override
  void didChangeDependencies() {
    _controller?.dispose();
    final model = Provider.of<BrewModel>(context, listen: false);
    _controller = PageController(initialPage: model.slide);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _animateTo(int page) {
    _controller!.animateToPage(
      page,
      curve: kSlideCurve,
      duration: kSlideAnimation,
    );
  }

  void _next() {
    final model = Provider.of<BrewModel>(context, listen: false);
    _animateTo(model.next());
  }

  void _previous() {
    final model = Provider.of<BrewModel>(context, listen: false);
    _animateTo(model.previous());
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<BrewModel>(context);
    return Scaffold(
      body: ScrollConfiguration(
        behavior: _MouseDragScrollBehavior(),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: PageView(
                controller: _controller,
                physics: const AlwaysScrollableScrollPhysics(),
                onPageChanged: model.setSlide,
                children: kSlides.map((label) => _Slide(label)).toList(),
              ),
            ),
            if (model.isBusy)
              const Positioned(
                top: kPadding,
                right: kPadding * 4,
                child: CircularProgressIndicator(),
              ),
            Positioned(
              top: 0,
              bottom: 0,
              left: kSpacing,
              child: IconButton(
                onPressed: model.hasPrevious ? _previous : null,
                icon: const Icon(Icons.chevron_left),
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              right: kSpacing,
              child: IconButton(
                onPressed: model.hasNext ? _next : null,
                icon: const Icon(Icons.chevron_right),
              ),
            ),
            Positioned(
              top: kPadding,
              left: kPadding,
              right: kPadding,
              bottom: kPadding,
              child: Column(
                children: <Widget>[
                  Text(
                    'We are brewing your infrastructure',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: model.isBusy ? null : model.makeCoffee,
                    child: const Text('Make coffee!'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide(this.label, {Key? key}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        label,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}

// https://flutter.dev/docs/release/breaking-changes/default-scroll-behavior-drag#setting-a-custom-scrollbehavior-for-your-application
class _MouseDragScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class BrewModel extends ChangeNotifier {
  BrewModel(this._api, this._count) : assert(_count > 0);

  final Api _api;
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
      _timer = Timer.periodic(kSlideDelay, (_) {
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
    final response = await _api.request();
    if (response == true) {
      _onSuccess();
    } else {
      _onFailure();
    }
    _setBusy(false);
  }
}
