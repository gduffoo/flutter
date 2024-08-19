class WrongCredential implements Exception {}

class InvalidToken implements Exception {}

class Connectiontimeout implements Exception {}

class CustoError implements Exception {
  final String message;
  final int errorCode;

  CustoError(this.message, this.errorCode);
}
