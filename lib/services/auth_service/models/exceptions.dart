class AuthException implements Exception {
  final String message;
  final int? code; // Optional, can be used to distinguish types of errors

  AuthException(this.message, {this.code});

  @override
  String toString() {
    if (code != null) {
      return "AuthException($code): $message";
    } else {
      return "AuthException: $message";
    }
  }
}
