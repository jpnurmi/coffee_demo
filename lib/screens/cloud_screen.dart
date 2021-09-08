import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';
import '../routes.dart';

class CloudProvider {
  const CloudProvider(this.asset, [this.title = '']);
  final String asset;
  final String title;
}

const kProviders = [
  CloudProvider('k8s.svg', 'Private Cloud'),
  CloudProvider('google.png'),
  CloudProvider('azure.png', 'Public Cloud'),
  CloudProvider('aws.svg'),
];

class CloudScreen extends StatelessWidget {
  const CloudScreen({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => const CloudScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Column(
          children: <Widget>[
            Text(
              'Select a substrate',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: kSpacing),
            const Text('Where do you want your apps stack to run?'),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kSpacing),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var i = 0; i < kProviders.length; ++i)
                    Expanded(
                      child: _CloudProviderButton(
                        asset: kProviders[i].asset,
                        title: kProviders[i].title,
                        onPressed: () =>
                            Navigator.of(context).pushNamed(Routes.coffee),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: kSpacing),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _CloudProviderButton extends StatelessWidget {
  const _CloudProviderButton({
    Key? key,
    required this.asset,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  final String asset;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(title),
        AspectRatio(
          aspectRatio: 1,
          child: Padding(
            padding: const EdgeInsets.all(kSpacing),
            child: ElevatedButton(
              onPressed: onPressed,
              child: asset.endsWith('.svg')
                  ? SvgPicture.asset('assets/$asset', fit: BoxFit.contain)
                  : Image.asset('assets/$asset', fit: BoxFit.contain),
            ),
          ),
        ),
      ],
    );
  }
}
