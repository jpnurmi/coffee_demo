import 'package:yaml/yaml.dart';

class Config {
  late final String url;
  late final String method;
  late final String username;
  late final String password;
  late final List<String> privateVendors;
  late final List<String> publicVendors;

  Future<void> init(String config) async {
    final yaml = await loadYaml(config) as YamlMap;
    url = yaml['url'] as String;
    method = yaml['method'] as String;
    username = yaml['username'] as String;
    password = yaml['password'] as String;
    privateVendors = yaml.vendors('private');
    publicVendors = yaml.vendors('public');
  }
}

extension _VendorYaml on YamlMap {
  List<String> vendors(String type) =>
      (this['vendors'][type] as YamlList).toList().cast();
}
