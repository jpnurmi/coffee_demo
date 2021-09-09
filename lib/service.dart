import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class Service {
  Service(this._dio);

  static BaseOptions makeOptions({
    required String url,
    required String method,
    required String username,
    required String password,
  }) {
    final basicAuth = base64.encode(latin1.encode('$username:$password'));
    return BaseOptions(
      baseUrl: url,
      method: method,
      headers: {HttpHeaders.authorizationHeader: 'Basic $basicAuth'},
    );
  }

  final Dio _dio;
  String? _vendor;
  String? _coffee;
  String? _error;

  String get vendor => _vendor ??= '';
  void selectVendor(String vendor) => _vendor = vendor;

  String get coffee => _coffee ?? '';
  void selectCoffee(String coffee) => _coffee = coffee;

  String? get error => _error;

  Future<bool> healthCheck() async {
    return _post('/health_check', {'msg_type': 'health_check'});
  }

  Future<bool> makeCoffee() async {
    return _post(
      '/coffee_order',
      {
        'msg_type': 'coffee_order',
        'coffee_type': coffee,
        'coffee_size': 'large',
      },
    );
  }

  Future<bool> _post(String path, Map<String, dynamic> formData) async {
    formData.addAll({
      'vendor': vendor,
      'requested_at': DateTime.now().toIso8601String(),
      'msg_direction': 'from_kiosk',
    });
    try {
      final response = await _dio.request(
        path,
        data: FormData.fromMap(formData),
        options: Options(responseType: ResponseType.json),
      );
      return response.data['status'] == 'ok';
    } on DioError catch (e) {
      _error = e.message;
    }
    return false;
  }
}
