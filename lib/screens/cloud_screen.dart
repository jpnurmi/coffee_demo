import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';
import '../routes.dart';

class CloudProvider {
  const CloudProvider({required this.vendor, required this.public});
  final String vendor;
  final bool public;
}

const kProviders = [
  CloudProvider(vendor: 'mk8', public: false),
  CloudProvider(vendor: 'gcp', public: true),
  CloudProvider(vendor: 'azu', public: true),
  CloudProvider(vendor: 'aws', public: true),
  CloudProvider(vendor: 'doc', public: true),
];

class CloudScreen extends StatelessWidget {
  const CloudScreen({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => const CloudScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(height: kPadding),
          Text(
            'Select a substrate',
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: kSpacing),
          const Text('Where do you want your apps stack to run?'),
          const SizedBox(height: kPadding),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _CloudProviderGrid(
                  title: 'Private Cloud',
                  providers: kProviders.where((provider) => !provider.public),
                ),
                _CloudProviderGrid(
                  title: 'Public Cloud',
                  providers: kProviders.where((provider) => provider.public),
                ),
              ],
            ),
          ),
          const SizedBox(height: kSpacing),
        ],
      ),
    );
  }
}

class _CloudProviderButton extends StatelessWidget {
  const _CloudProviderButton({
    Key? key,
    required this.vendor,
    required this.onPressed,
  }) : super(key: key);

  final String vendor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kSpacing),
      child: AspectRatio(
        aspectRatio: 1,
        child: ElevatedButton(
          onPressed: onPressed,
          child: SvgPicture.asset('assets/$vendor.svg', fit: BoxFit.contain),
        ),
      ),
    );
  }
}

class _CloudProviderGrid extends StatelessWidget {
  const _CloudProviderGrid({
    Key? key,
    required this.title,
    required this.providers,
  }) : super(key: key);

  final String title;
  final Iterable<CloudProvider> providers;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(title),
        const SizedBox(height: kSpacing / 2),
        Expanded(
          child: GridView.count(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            crossAxisCount: 2,
            children: providers.map((provider) {
              return _CloudProviderButton(
                vendor: provider.vendor,
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.coffee);
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
