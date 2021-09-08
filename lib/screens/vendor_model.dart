import '../service.dart';

class Vendor {
  const Vendor({required this.name, required this.public});
  final String name;
  final bool public;
}

const kVendors = [
  Vendor(name: 'mk8', public: false),
  Vendor(name: 'gcp', public: true),
  Vendor(name: 'azu', public: true),
  Vendor(name: 'aws', public: true),
  Vendor(name: 'doc', public: true),
];

class VendorModel {
  VendorModel(this._service);

  final Service _service;

  void selectVendor(Vendor vendor) => _service.selectVendor(vendor.name);
}
