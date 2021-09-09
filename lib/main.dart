import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'config.dart';
import 'routes.dart';
import 'screens.dart';
import 'service.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final config = Config();
  await config.init(await rootBundle.loadString('assets/config.yaml'));

  final options = Service.makeOptions(
    url: config.url,
    username: config.username,
    password: config.password,
  );

  runApp(MultiProvider(
    providers: [
      Provider.value(value: config),
      Provider(create: (_) => Service(Dio(options))),
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
      theme: theme,
      initialRoute: Routes.home,
      routes: const {
        Routes.home: HomeScreen.create,
        Routes.intro: IntroScreen.create,
        Routes.cloud: VendorScreen.create,
        Routes.coffee: CoffeeScreen.create,
        Routes.brew: BrewScreen.create,
        Routes.result: ResultScreen.create,
      },
    );
  }
}
