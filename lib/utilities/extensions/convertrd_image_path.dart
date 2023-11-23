import '../../di/environment_type.dart';

/// This Extension hold this conversion
/// and
/// formatting path photo from API.
extension ImageURL on String {
  String get convertedImagePath {
    return EnvironmentType.development.environment.imageBaseURL +
        (replaceAll('\\', '/'));
  }
}
