import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizard_router/wizard_router.dart';

import '../constants.dart';

const kLabels = ['FREE COFFEE', 'FREE SOFTWARE'];
const kInterval = Duration(seconds: 2);

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeModel(kLabels.length),
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
        onTap: Wizard.of(context).next,
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Center(
            child: Column(
              children: <Widget>[
                const Spacer(flex: 2),
                ElevatedButton(
                  onPressed: Wizard.of(context).next,
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    primary: Theme.of(context).colorScheme.background,
                    onPrimary: Theme.of(context).highlightColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(kSpacing),
                    child: IndexedStack(
                      index: model.index,
                      children: kLabels
                          .map((label) => Text(label,
                              style: Theme.of(context).textTheme.headline1))
                          .toList(),
                    ),
                  ),
                ),
                const Spacer(flex: 1),
                Text(
                  'Touch the screen to start',
                  style: Theme.of(context).textTheme.headline4,
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
