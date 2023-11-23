/// App Custom Errors
///
class LocalizedError implements Exception {
  final String message;

  LocalizedError({
    required this.message,
  });
}
