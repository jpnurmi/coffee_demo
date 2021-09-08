import '../config.dart';
import '../service.dart';

class VendorModel {
  VendorModel(this._config, this._service);

  final Config _config;
  final Service _service;

  Iterable<String> get privateVendors => _config.privateVendors;
  Iterable<String> get publicVendors => _config.publicVendors;

  void selectVendor(String vendor) => _service.selectVendor(vendor);
}
