import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'config.dart';
import 'constants.dart';
import 'routes.dart';
import 'screens.dart';
import 'service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final config = Config();
  await config.init(await rootBundle.loadString('assets/config.yaml'));

  runApp(MultiProvider(
    providers: [
      Provider.value(value: config),
      Provider(create: (_) => Service(config.url)),
    ],
    child: const MyApp(),
  ));
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
