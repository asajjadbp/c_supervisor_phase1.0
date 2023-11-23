class ConfigurationConstants {
  /// Pagination list - number of items per page
  static const pageSize = 20;

  /// Input text length limit for [TextFieldFormRow]
  static const defaultInputTextLengthLimit = 100;

  /// Input text length limit for mobile fields
  static const mobileInputTextLengthLimit = 11;

  /// Input text length limit for password fields
  static const passwordInputTextLengthLimit = 14;

  /// Input text length limit for [MultilineTextFormField]
  static const defaultMultiLineInputTextLengthLimit = 500;

  /// Number of min items in list required to show ShowMoreButton
  ///
  /// if the number of items in list exceeds the [showMoreMinLimit]
  /// then the showMore button appears
  static const showMoreMinLimit = 2;

  /// Input text length limit for search fields
  static const defaultSearchTextLengthLimit = 25;
}
