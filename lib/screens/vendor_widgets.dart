import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class VendorGrid extends StatelessWidget {
  const VendorGrid({
    Key? key,
    required this.title,
    required this.vendors,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final Iterable<String> vendors;
  final ValueChanged<String> onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(title),
        Expanded(
          child: GridView.count(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            crossAxisCount: 2,
            children: vendors.map((vendor) {
              return _VendorButton(
                vendor: vendor,
                onPressed: () => onPressed(vendor),
              );
            }).toList(),
          ),
        ),
      ],
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
