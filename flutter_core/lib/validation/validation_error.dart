import '../extensions/string.dart';

class ValidationError implements Exception {
  /// Created error with message.
  /// White spaces and new lines will be trimmed and first letter should be capitalized.
  ///
  ValidationError({
    required String message,
  }) : message = message.trim().capitalizeFirstLetter();

  /// Creates error for required field name.
  /// - Example: `Required Email`
  ///
  factory ValidationError.required(String errorMessage) {
    return ValidationError(message: errorMessage);
  }

  /// Creates error for invalid field name.
  /// - Example: `Invalid Email`
  ///
  factory ValidationError.invalid(String errorMessage) {
    return ValidationError(message: errorMessage);
  }

  factory ValidationError.fieldsNotMatching(String errorMessage) {
    return ValidationError(message: errorMessage);
  }

  /// Message
  ///
  final String message;

  @override
  String toString() {
    return message;
  }
}
