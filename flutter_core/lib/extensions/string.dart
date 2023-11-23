extension StringExtensions on String {
  /// Capitalize first letter of a string
  String capitalizeFirstLetter() {
    if (isNotEmpty) {
      return "${this[0].toUpperCase()}${substring(1)}";
    } else {
      return this;
    }
  }
}
