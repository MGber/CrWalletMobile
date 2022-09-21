class NetworkException {
  final String _message;
  final String _prefix;

  NetworkException(this._message, this._prefix);

  @override
  String toString() {
    return "$_prefix : $_message";
  }
}

class InternalServerException extends NetworkException {
  InternalServerException(String message)
      : super(message, "Internal server error.");
}

class NotFoundException extends NetworkException {
  NotFoundException(String message) : super(message, "Not found");
}

class ForbiddenException extends NetworkException {
  ForbiddenException(String message) : super(message, "Forbidden");
}

class NetworkConnectionError extends NetworkException {
  NetworkConnectionError(String message)
      : super(message, "Network connection error.");
}
