import 'package:dio/dio.dart';

class DioConfig {
  DioConfig._();

  static final DioConfig _instance = DioConfig._();
  factory DioConfig() => _instance;

  Dio? _dio;

  Dio get dio {
    _dio ??= _createDio();
    return _dio!;
  }

  Dio _createDio() {
    final dio = Dio();
    dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    );
    return dio;
  }
}
