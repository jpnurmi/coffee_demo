import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../routes.dart';

const kLabels = ['FREE COFFEE', 'FREE SOFTWARE'];
const kInterval = Duration(seconds: 2);

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeModel(kLabels),
      child: const HomeScreen(),
    );
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeModel>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeModel>(context);
    return Scaffold(
      body: InkWell(
        onTap: () => Navigator.of(context).pushNamed(Routes.cloudProvider),
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Center(
            child: Column(
              children: <Widget>[
                const Spacer(flex: 2),
                Text(
                  model.label,
                  style: Theme.of(context).textTheme.headline1!,
                ),
                const Spacer(flex: 1),
                Text(
                  'Touch the screen to start',
                  style: Theme.of(context).textTheme.headline4!,
                ),
                const Spacer(flex: 3),
                const Text('Powered by Canonical and Open Source.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeModel extends ChangeNotifier {
  HomeModel(this._labels);

  int _index = 0;
  late Timer _timer;
  final List<String> _labels;

  String get label => _labels[_index];

  void next() {
    _index = (_index + 1) % kLabels.length;
    notifyListeners();
  }

  void init() => _timer = Timer.periodic(kInterval, (_) => next());

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
