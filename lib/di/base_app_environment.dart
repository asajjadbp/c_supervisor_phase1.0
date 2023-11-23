class BaseAppEnvironment {
  const BaseAppEnvironment({
    required this.appName,
    required this.baseURL,
    required this.imageBaseURL,
  });
  final String baseURL;
  final String imageBaseURL;
  final String appName;
}
