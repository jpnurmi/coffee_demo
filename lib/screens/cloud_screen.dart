import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wizard_router/wizard_router.dart';

import '../constants.dart';

class CloudScreen extends StatelessWidget {
  const CloudScreen({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => const CloudScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Select a substrate',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
          const SizedBox(height: kSpacing),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kSpacing),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var i = 0; i < kProviders.length; ++i)
                  Expanded(
                    child: _CloudProviderButton(
                      asset: kProviders[i],
                      onPressed: () => Wizard.of(context).next(arguments: i),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: kSpacing),
          const Spacer(),
        ],
      ),
    );
  }
}

class _CloudProviderButton extends StatelessWidget {
  const _CloudProviderButton({
    Key? key,
    required this.asset,
    required this.onPressed,
  }) : super(key: key);

  final String asset;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(kSpacing),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 4,
            primary: Theme.of(context).colorScheme.background,
            onPrimary: Theme.of(context).highlightColor,
          ),
          child: asset.endsWith('.svg')
              ? SvgPicture.asset('assets/$asset', fit: BoxFit.contain)
              : Image.asset('assets/$asset', fit: BoxFit.contain),
        ),
      ),
    );
  }
}
