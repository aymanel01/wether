import 'package:dio/dio.dart';

Dio createDio() {
  final dio = Dio();
  dio.options = BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
  );
  return dio;
}
