import 'dart:math';

import 'package:dio/dio.dart';

class Service {
  Dio? _dio;
  CancelToken? _token;
  String? _vendor;
  String? _coffee;

  Dio get dio => _dio ??= Dio();

  Future<void> init() async {}

  String get vendor => _vendor ??= '';
  void selectVendor(String vendor) => _vendor = vendor;

  String get coffee => _coffee ?? '';
  void selectCoffee(String coffee) => _coffee = coffee;

  static bool _getResult(Response response) => Random().nextBool();

  static Future<Response> _randomDelay(Response response) {
    final delay = Duration(seconds: 1 + Random().nextInt(4));
    return Future.delayed(delay, () => response);
  }

  Future<bool> request() {
    final response = dio.get(
      'http://geoname-lookup.ubuntu.com/',
      queryParameters: <String, String>{'query': 'London'},
      cancelToken: _token = CancelToken(),
      options: Options(responseType: ResponseType.plain),
    );
    return response.then(_randomDelay).then(_getResult);
  }

  Future<void> cancel() async => _token?.cancel();
}
