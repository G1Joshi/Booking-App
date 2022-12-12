import 'package:booking_frontend/config/config.dart';
import 'package:dio/dio.dart';

class Client {
  Client() {
    initClient();
  }

  late Dio _dio;

  void initClient() {
    final dioOptions = BaseOptions(
      baseUrl: baseUrl,
      contentType: Headers.jsonContentType,
      headers: {
        Headers.acceptHeader: Headers.jsonContentType,
      },
    );

    _dio = Dio(dioOptions);

    _dio.interceptors.add(LogInterceptor());
  }

  Future<Map<String, dynamic>> get({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
      );
      return response.data ?? {};
    } catch (_) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> post({
    required String path,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        path,
        data: data,
      );
      return response.data ?? {};
    } catch (_) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> put({
    required String path,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        path,
        data: data,
      );
      return response.data ?? {};
    } catch (_) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> delete({
    required String path,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.delete<Map<String, dynamic>>(
        path,
        data: data,
      );
      return response.data ?? {};
    } catch (_) {
      rethrow;
    }
  }
}
