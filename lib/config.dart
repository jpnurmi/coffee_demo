import 'package:yaml/yaml.dart';

class Config {
  late final String _url;
  late final String _username;
  late final String _password;
  late final List<String> _privateVendors;
  late final List<String> _publicVendors;

  Future<void> init(String config) async {
    final yaml = await loadYaml(config) as YamlMap;
    _url = yaml['url'] as String;
    _username = yaml['username'] as String;
    _password = yaml['password'] as String;
    _privateVendors = yaml.vendors('private');
    _publicVendors = yaml.vendors('public');
  }

  String get url => _url;
  String get username => _username;
  String get password => _password;

  List<String> get privateVendors => _privateVendors;
  List<String> get publicVendors => _publicVendors;
}

extension _VendorYaml on YamlMap {
  List<String> vendors(String type) =>
      (this['vendors'][type] as YamlList).toList().cast();
}
