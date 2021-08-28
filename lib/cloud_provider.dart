import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'constants.dart';
import 'routes.dart';

class CloudProviderPage extends StatelessWidget {
  const CloudProviderPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => const CloudProviderPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'SELECT CLOUD PROVIDER',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
          ),
          const SizedBox(height: kSpacing),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kSpacing),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: kProviders.map((asset) {
                return Expanded(
                  child: _CloudProviderButton(
                    asset: asset,
                    onPressed: () =>
                        Navigator.of(context).pushNamed(Routes.slideShow),
                  ),
                );
              }).toList(),
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
            primary: Colors.white,
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
