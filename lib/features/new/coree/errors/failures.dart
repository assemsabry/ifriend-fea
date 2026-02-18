import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [getMessage()];

  String getMessage() {
    throw UnimplementedError();
  }
}

class OfflineFailure extends Failure {
  @override
  String getMessage() => "No internet connection";
}

class EmptyCacheFailure extends Failure {
  @override
  String getMessage() => "Error in cache";
}

class ServerFailure extends Failure {
  final Exception error;

  ServerFailure({required this.error});

  @override
  String getMessage() => error.toString();
}

class NetworkFailure extends Failure {
  final String message;

  NetworkFailure(this.message);

  @override
  String getMessage() => message;
}
