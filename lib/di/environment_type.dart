import 'base_app_environment.dart';

enum EnvironmentType {
  development(
    ///todo baseURL
    BaseAppEnvironment(
      appName: 'Supervisor',
      baseURL: 'https://supapitest.catalist-me.com/',
      imageBaseURL: 'https://testapi.catalist-me.com/',
    ),
  ),
  production(
    BaseAppEnvironment(
      appName: 'supervisor-Production',
      baseURL: '',
      imageBaseURL: '',
    ),
  );

  const EnvironmentType(this.environment);

  final BaseAppEnvironment environment;
}
