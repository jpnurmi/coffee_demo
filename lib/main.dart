import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wizard_router/wizard_router.dart';
import 'package:yaru/yaru.dart' as yaru;

import 'api.dart';
import 'brew_coffee.dart';
import 'cloud_provider.dart';
import 'constants.dart';
import 'routes.dart';
import 'screens.dart';
import 'slide_show.dart';
import 'transitions.dart';

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
      theme: yaru.lightTheme,
      home: const Wizard(
        initialRoute: Routes.home,
        routes: {
          Routes.home: HomeScreen.create,
          Routes.intro: IntroScreen.create,
          Routes.cloudProvider: CloudProviderPage.create,
          Routes.slideShow: SlideShowPage.create,
          Routes.brewCoffee: BrewCoffeePage.create,
        },
      ),
    );
  }
}
