import 'package:dio/dio.dart';

class DioErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage;

    if (err.response != null) {
      final statusCode = err.response?.statusCode ?? 0;

      if (statusCode >= 300) {
        if (err.response?.data is Map<String, dynamic>) {
          errorMessage = err.response?.data['message']?.toString() ??
              err.response?.statusMessage ??
              'Unknown error';
        } else {
          errorMessage = err.response?.statusMessage ?? 'Unknown error';
        }
      } else {
        errorMessage = 'Something went wrong';
      }
    } else {
      errorMessage = 'Connection error';
    }

    // Optionally log error message for debugging
    print('Dio error intercepted: $errorMessage');

    final customError = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      error: errorMessage,
      type: err.type,
    );

    super.onError(customError, handler);
  }
}
