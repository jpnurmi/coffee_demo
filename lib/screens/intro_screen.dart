import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wizard_router/wizard_router.dart';

import '../constants.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => const IntroScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'A coffee machine running on Kubernetes?',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: kPadding),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Html(
                    data: '''
<p>This is no ordinary espresso.<p/>
<p>Ok, it might taste the same as a regular cup, but the Flutter app controlling this screen is NOT wired directly to the coffee machine!</p>
<p>The actual "get coffee" command goes through a Kubernetes cluster and a really cool stack of open source apps before pressing the button on this espresso machine.</p>
<p>Don't believe it? Visit <a href="https://juju.is/brew">juju.is/brew<a/> to see the Grafana dashboards and logs!</p>
''',
                    style: {'body': Style(fontSize: FontSize.larger)},
                  ),
                ),
              ),
              const SizedBox(height: kSpacing),
              OutlinedButton(
                onPressed: Wizard.of(context).next,
                child: const Text('NEXT >'),
              ),
              const SizedBox(height: kSpacing),
              const Text(
                  'This demo was presented in the talk "Coffee Beyond and the Edge: A Hardware Engineer\'s Guide to Kubernetes" by Pedro Cruz and Alex Chalkias at the Kubernetes on Edge Day 2021.'),
            ],
          ),
        ),
      ),
    );
  }
}
