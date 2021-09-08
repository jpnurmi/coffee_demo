import 'package:yaml/yaml.dart';

class Config {
  late final List<String> _privateVendors;
  late final List<String> _publicVendors;
  late final String _url;

  Future<void> init(String config) async {
    final yaml = await loadYaml(config) as YamlMap;
    _url = yaml['url'] as String;
    _privateVendors = yaml.vendors('private');
    _publicVendors = yaml.vendors('public');
  }

  String get url => _url;
  List<String> get privateVendors => _privateVendors;
  List<String> get publicVendors => _publicVendors;
}

extension _VendorYaml on YamlMap {
  List<String> vendors(String type) =>
      (this['vendors'][type] as YamlList).toList().cast();
}
