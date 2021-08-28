import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yaru/yaru.dart' as yaru;

import 'brew_coffee.dart';
import 'cloud_provider.dart';
import 'constants.dart';
import 'routes.dart';
import 'slide_show.dart';
import 'transitions.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Stack(
        alignment: Alignment.center,
        children: [
          MaterialApp(
            title: 'Coffee demo',
            theme: yaru.lightTheme.copyWith(
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.linux: SlideTransitionsBuilder(),
                },
              ),
            ),
            initialRoute: '/',
            routes: {
              Routes.cloudProvider: CloudProviderPage.create,
              Routes.slideShow: SlideShowPage.create,
              Routes.brewCoffee: BrewCoffeePage.create,
            },
          ),
          Positioned(
            bottom: kPadding,
            right: kPadding,
            child: SvgPicture.asset(
              'assets/ubuntu.svg',
              alignment: Alignment.bottomRight,
            ),
          ),
        ],
      ),
    );
  }
}
