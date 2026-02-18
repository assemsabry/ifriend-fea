class ServerException implements Exception {
  final String message;

  ServerException(this.message);

  @override
  String toString() => message;
}

class EmptyCacheException implements Exception {}

class OfflineException implements Exception {}
