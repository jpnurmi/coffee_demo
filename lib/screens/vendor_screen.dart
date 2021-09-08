import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../routes.dart';
import '../service.dart';
import 'vendor_model.dart';

class CloudScreen extends StatelessWidget {
  const CloudScreen({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    final service = Provider.of<Service>(context, listen: false);
    return Provider(
      create: (_) => VendorModel(service),
      child: const CloudScreen(),
    );
  }

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
                _VendorGrid(
                  title: 'Private Cloud',
                  vendors: kVendors.where((vendor) => !vendor.public),
                ),
                _VendorGrid(
                  title: 'Public Cloud',
                  vendors: kVendors.where((vendor) => vendor.public),
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

class _VendorButton extends StatelessWidget {
  const _VendorButton({
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

class _VendorGrid extends StatelessWidget {
  const _VendorGrid({
    Key? key,
    required this.title,
    required this.vendors,
  }) : super(key: key);

  final String title;
  final Iterable<Vendor> vendors;

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
            children: vendors.map((vendor) {
              return _VendorButton(
                vendor: vendor.name,
                onPressed: () {
                  final model =
                      Provider.of<VendorModel>(context, listen: false);
                  model.selectVendor(vendor);
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
