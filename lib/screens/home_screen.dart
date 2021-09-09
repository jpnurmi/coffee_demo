import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../routes.dart';
import 'home_model.dart';

const kLabels = ['FREE COFFEE', 'FREE SOFTWARE'];

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
    final buttonTheme = Theme.of(context).textTheme.button!;
    final buttonStyle = buttonTheme.copyWith(fontSize: 96);
    return Scaffold(
      body: InkWell(
        onTap: () => Navigator.of(context).pushNamed(Routes.intro),
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: Center(
            child: Column(
              children: <Widget>[
                const Spacer(flex: 2),
                ElevatedButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(Routes.intro),
                  child: IndexedStack(
                    index: model.index,
                    children: kLabels
                        .map((label) => Text(label, style: buttonStyle))
                        .toList(),
                  ),
                ),
                const Spacer(flex: 1),
                Text(
                  'Touch the screen to start',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const Spacer(flex: 3),
                Text(
                  'Powered by Canonical and Open Source.',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
