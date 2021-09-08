import 'package:yaml/yaml.dart';

class Config {
  static late final List<String> _privateVendors;
  static late final List<String> _publicVendors;

  Future<void> init(String config) async {
    final yaml = await loadYaml(config) as YamlMap;
    _privateVendors = yaml.vendors('private');
    _publicVendors = yaml.vendors('public');
  }

  List<String> get privateVendors => _privateVendors;
  List<String> get publicVendors => _publicVendors;
}

extension _VendorYaml on YamlMap {
  List<String> vendors(String type) =>
      (this['vendors'][type] as YamlList).toList().cast();
}
