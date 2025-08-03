class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({this.message = 'Server Exception', this.statusCode});

  @override
  String toString() => 'ServerException: $message (Status: $statusCode)';
}

class CacheException implements Exception {
  final String message;

  CacheException({this.message = 'Cache Exception'});

  @override
  String toString() => 'CacheException: $message';
}
