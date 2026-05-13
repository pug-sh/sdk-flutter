class PugException implements Exception {
  const PugException(this.message);

  final String message;

  @override
  String toString() => 'PugException($message)';
}

class PugTransportException implements Exception {
  const PugTransportException(
    this.message, {
    this.code,
    this.permanent = false,
    this.stackTrace,
  });

  final String message;
  final String? code;
  final bool permanent;
  final StackTrace? stackTrace;

  bool get isPermanent => permanent;

  @override
  String toString() => 'PugTransportException($message)';
}
