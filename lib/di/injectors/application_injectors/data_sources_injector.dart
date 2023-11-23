import 'package:c_supervisor/data/data_sources/local/index.dart';
import 'package:c_supervisor/data/data_sources/remote/index.dart';
import 'package:c_supervisor/di/base_injector.dart';
import 'package:c_supervisor/di/injectors/dependancy_injector.dart';
import 'package:flutter_core/utilities/shared_preferences_client/my_shared_preferences.dart';

/// [DataSourcesInjector] hold all application data sources dependencies
class DataSourcesInjector extends BaseInjector {
  static final dataSourcesInjectors = [
    () => diInstance.registerLazySingleton<ApplicationRemoteDS>(
          () => ApplicationRemoteDS(
            networkManager,
          ),
        ),
    () => diInstance.registerLazySingletonAsync<AppSharedPrefsClient>(
        () async => AppSharedPrefsClient(
            storageInstance: (await MySharedPreferences.getInstance())!)),
  ];

  /// iterate and inject all data sources
  @override
  Future<void> injectModules() async {
    for (final dataSourceInjector in dataSourcesInjectors) {
      dataSourceInjector.call();
    }
  }
}
