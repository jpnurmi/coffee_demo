import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api.dart';
import 'constants.dart';
import 'routes.dart';
import 'screens.dart';

void main() async {
  final api = Api();
  await api.init();
  runApp(Provider.value(value: api, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee demo',
      theme: ThemeData.light().copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.black87,
            padding: const EdgeInsets.all(kSpacing),
            minimumSize: const Size(192, 48),
          ),
        ),
      ),
      initialRoute: Routes.home,
      routes: const {
        Routes.home: HomeScreen.create,
        Routes.intro: IntroScreen.create,
        Routes.cloud: CloudScreen.create,
        Routes.coffee: CoffeeScreen.create,
        Routes.brew: BrewScreen.create,
        Routes.result: ResultScreen.create,
      },
    );
  }
}
