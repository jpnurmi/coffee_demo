import 'package:dio/dio.dart';

class Service {
  Service(this.serverAddress);

  Dio? _dio;
  String? _vendor;
  String? _coffee;
  String? _error;
  final String serverAddress;

  Dio get dio => _dio ??= Dio();

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
    try {
      final response = await dio.post(
        '$serverAddress/$path',
        data: FormData.fromMap(formData
          ..addAll({
            'vendor': vendor,
            'requested_at': DateTime.now().toIso8601String(),
            'msg_direction': 'from_kiosk',
          })),
        options: Options(responseType: ResponseType.json),
      );
      return response.data['status'] == 'ok';
    } on DioError catch (e) {
      _error = e.message;
      return false;
    }
  }
}
