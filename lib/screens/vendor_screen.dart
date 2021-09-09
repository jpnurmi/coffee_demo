import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config.dart';
import '../constants.dart';
import '../routes.dart';
import '../service.dart';
import 'vendor_model.dart';
import 'vendor_widgets.dart';

class VendorScreen extends StatelessWidget {
  const VendorScreen({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    final config = Provider.of<Config>(context, listen: false);
    final service = Provider.of<Service>(context, listen: false);
    return Provider(
      create: (_) => VendorModel(config, service),
      child: const VendorScreen(),
    );
  }

  void _selectVendor(BuildContext context, String vendor) {
    final model = Provider.of<VendorModel>(context, listen: false);
    model.selectVendor(vendor);
    Navigator.of(context).pushNamed(Routes.coffee);
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<VendorModel>(context);
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
                VendorGrid(
                  title: 'Private Cloud',
                  vendors: model.privateVendors,
                  onPressed: (vendor) => _selectVendor(context, vendor),
                ),
                VendorGrid(
                  title: 'Public Cloud',
                  vendors: model.publicVendors,
                  onPressed: (vendor) => _selectVendor(context, vendor),
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
