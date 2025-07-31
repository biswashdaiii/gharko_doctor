import 'package:dio/dio.dart';
import 'package:gharko_doctor/app/constant/api_endpoints.dart';
import 'package:gharko_doctor/core/network/dio_error_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  final Dio _dio;

  Dio get dio => _dio;

  ApiService(this._dio) {
    _dio
      ..options.baseUrl = ApiEndpoints.baseUrl
      ..options.connectTimeout = ApiEndpoints.connectionTimeout
      ..options.receiveTimeout = ApiEndpoints.receiveTimeout
      ..options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      }
      ..interceptors.addAll([
        DioErrorInterceptor(),
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
        ),
      ]);
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return _dio.get(
      path,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
  }) {
    return _dio.post(
      path,
      data: data,
      options: Options(headers: headers),
    );
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
  }) {
    return _dio.put(
      path,
      data: data,
      options: Options(headers: headers),
    );
  }

  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
  }) {
    return _dio.delete(
      path,
      data: data,
      options: Options(headers: headers),
    );
  }
}
