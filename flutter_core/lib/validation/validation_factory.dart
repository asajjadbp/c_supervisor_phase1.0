import 'package:flutter_core/flutter_core.dart';

/// Default validators
extension ValidatorFactory on ValidatorConvertible {
  /// Required field validator
  static ValidatorConvertible required(String fieldName, String errorMessage) =>
      RequiredFieldValidator('$fieldName $errorMessage');

  /// Email validator
  static ValidatorConvertible email({
    required String requiredErrorMessage,
    required String invalidErrorMessage,
    bool isRequired = false,
    String? fieldName,
  }) =>
      EmailValidator(
        requiredErrorMessage: '$requiredErrorMessage $fieldName',
        invalidErrorMessage: '$fieldName $invalidErrorMessage',
        isRequired: isRequired,
      );

  /// Full name validator for Ar/ En
  static ValidatorConvertible fullName({
    required String requiredErrorMessage,
    required String invalidErrorMessage,
    bool isRequired = false,
    String? fieldName,
  }) =>
      FullNameValidator(
        requiredErrorMessage: '$requiredErrorMessage $fieldName',
        invalidErrorMessage: '$fieldName $invalidErrorMessage',
        isRequired: isRequired,
      );

  /// Egyptian mobile number validator
  static ValidatorConvertible mobileNumber({
    required String requiredErrorMessage,
    required String invalidErrorMessage,
    bool isRequired = false,
    String? fieldName,
  }) =>
      MobileNumberValidator(
        requiredErrorMessage: '$requiredErrorMessage $fieldName',
        invalidErrorMessage: '$fieldName $invalidErrorMessage',
        isRequired: isRequired
      );

  /// Password validator
  static ValidatorConvertible password(String requiredErrorMessage,
          String invalidErrorMessage, String fieldName) =>
      PasswordValidator(
        requiredErrorMessage: '$requiredErrorMessage $fieldName',
        invalidErrorMessage: '$fieldName $invalidErrorMessage',
      );

  /// Confirm password validator
  static ValidatorConvertible confirmPassword(
    String errorMessage,
    String? password,
  ) =>
      ConfirmPasswordValidator(errorMessage, password);

  /// Regex validator to be used in validating form fields
  /// according to a regex from the api and throw the invalid error message
  /// comes from the api in case that the value is invalid
  static ValidatorConvertible regex({
    required String fieldName,
    required String requiredErrorMessage,
    required String? invalidErrorMessage,
    required String? regex,
    required bool isRequired,
  }) =>
      RegexValidator(
        requiredErrorMessage: '$requiredErrorMessage $fieldName',
        invalidErrorMessage: invalidErrorMessage,
        regex: regex,
        isRequired: isRequired,
      );
}

abstract class ValidatorConvertible {
  /// Returns validated value or throws an error if any validation error occurs
  ///
  Result<String> validated(String? value);
}



/// Required Field Validator

abstract class MultiSelectionValidatorConvertible<ValueType> {
  /// Returns validated value or throws an error if any validation error occurs
  Result<String> validated(List<ValueType> value);
}

class RequiredFieldValidator implements ValidatorConvertible {
  RequiredFieldValidator(this.errorMessage);

  final String errorMessage;

  @override
  Result<String> validated(String? value) {
    final newValue = value ?? '';
    if (newValue.trim().isEmpty) {
      return Result.failure(ValidationError.required(errorMessage));
    }
    return Result.success(newValue);
  }
}

/// Regex validator with field name and regex
///
class RegexValidator implements ValidatorConvertible {
  RegexValidator({
    required this.requiredErrorMessage,
    required this.invalidErrorMessage,
    this.regex,
    this.isRequired = false,
  });

  final String requiredErrorMessage;
  final String? invalidErrorMessage;
  final String? regex;
  bool isRequired;

  @override
  Result<String> validated(String? value) {
    final newValue = value ?? '';

    if (isRequired) {
      final result =
          RequiredFieldValidator(requiredErrorMessage).validated(value);
      if (result.isError()) return result;
    }

    if (regex != null && newValue.isNotEmpty) {
      if (RegExp(regex!).hasMatch(newValue)) {
        return Result.success(newValue);
      }
      return Result.failure(ValidationError.invalid(invalidErrorMessage!));
    }

    return Result.success(newValue);
  }
}

/// Email Validator
///
class EmailValidator implements ValidatorConvertible {
  EmailValidator({
    required this.requiredErrorMessage,
    required this.invalidErrorMessage,
    this.regex,
    this.isRequired = false,
  });

  final String requiredErrorMessage;
  final String invalidErrorMessage;
  final bool isRequired;
  final String? regex;

  @override
  Result<String> validated(String? value) {
    return RegexValidator(
      requiredErrorMessage: requiredErrorMessage,
      invalidErrorMessage: invalidErrorMessage,
      isRequired: isRequired,
      regex: regex ??
          r'^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$',
    ).validated(value);
  }
}

/// Validate name which should be between 3-36 characters and can has characters, numbers and dot.
///
class FullNameValidator implements ValidatorConvertible {
  FullNameValidator({
    required this.requiredErrorMessage,
    required this.invalidErrorMessage,
    this.regex,
    this.isRequired = false,
  });

  final String requiredErrorMessage;
  final String invalidErrorMessage;
  final bool isRequired;
  final String? regex;

  @override
  Result<String> validated(String? value) {
    return RegexValidator(
      requiredErrorMessage: requiredErrorMessage,
      invalidErrorMessage: invalidErrorMessage,
      isRequired: isRequired,
      regex: regex ?? r'^[A-Za-z0-9٠-٩.ء-ي ]{3,100}$',
    ).validated(value);
  }
}

/// Validate mobile number which should start with 010, 011, 012, 015.
///
class MobileNumberValidator implements ValidatorConvertible {
  MobileNumberValidator({
    required this.requiredErrorMessage,
    required this.invalidErrorMessage,
    this.regex,
    this.isRequired = false,
  });

  final String requiredErrorMessage;
  final String invalidErrorMessage;
  final bool isRequired;
  final String? regex;

  @override
  Result<String> validated(String? value) {
    return RegexValidator(
      requiredErrorMessage: requiredErrorMessage,
      invalidErrorMessage: invalidErrorMessage,
      isRequired: isRequired,
      regex: regex ?? r'(^01[0-2-5]{1}\d{8}$)',
    ).validated(value);
  }
}

/// Validate password matching the regex.
///
class PasswordValidator implements ValidatorConvertible {
  PasswordValidator({
    required this.requiredErrorMessage,
    required this.invalidErrorMessage,
    this.regex,
    this.isRequired = true,
  });

  final String requiredErrorMessage;
  final String invalidErrorMessage;
  final bool isRequired;
  final String? regex;

  @override
  Result<String> validated(String? value) {
    final result =
        RequiredFieldValidator(requiredErrorMessage).validated(value);
    if (result.isError()) return result;

    return RegexValidator(
      requiredErrorMessage: requiredErrorMessage,
      invalidErrorMessage: invalidErrorMessage,
      isRequired: isRequired,
      regex: regex ?? r'(^[a-zA-Z0-9]{8,14}$)',
    ).validated(value);
  }
}


/// Validate confirm password which should match the password.
///
class ConfirmPasswordValidator implements ValidatorConvertible {
  ConfirmPasswordValidator(this.errorMessage, this.password);

  final String errorMessage;
  final String? password;

  @override
  Result<String> validated(String? passwordConfirmation) {
    final nonNullablePasswordConfirmation = passwordConfirmation ?? '';

    if (password == nonNullablePasswordConfirmation &&
        nonNullablePasswordConfirmation.trim().isNotEmpty) {
      return Result.success(nonNullablePasswordConfirmation);
    }

    return Result.failure(ValidationError.fieldsNotMatching(errorMessage));
  }
}

/// [MultiSelectionValidator]  used to validate on generic selected list that selected from bottom sheet
class MultiSelectionValidator<ValueType>
    implements MultiSelectionValidatorConvertible<ValueType> {
  final String fieldName;

  MultiSelectionValidator(this.fieldName);

  /// return Result.success("")  when [value] list not empty
  /// return [Result.failure(ValidationError.invalid(fieldName))]  which  give you failure with message
  @override
  Result<String> validated(List<ValueType> value) {
    return value.isNotEmpty
        ? Result.success("")
        : Result.failure(ValidationError.invalid(fieldName));
  }
}
